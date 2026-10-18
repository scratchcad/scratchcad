//! [`Selection`]: an immutable, cheaply clonable list of shapes with chainable filters.

use crate::{
    error::{Error, Result},
    math::normalize,
    selector,
    shape::Shape,
};
use glam::DVec3;
use std::{fmt, rc::Rc};

/// Tolerance used when comparing positions and directions in selectors.
pub const TOLERANCE: f64 = 1e-4;

/// An ordered list of shapes, usually the faces, edges or vertices of a [`Shape`].
///
/// Like [`Shape`], a selection is a cheap-to-clone handle and every filter returns a new
/// selection, so filters chain: `shape.faces().parallel_to(Z)?.farthest(Z)?.first()?`.
#[derive(Clone, Default)]
pub struct Selection {
    shapes: Rc<Vec<Shape>>,
}

impl Selection {
    pub fn new(shapes: Vec<Shape>) -> Self {
        Self { shapes: Rc::new(shapes) }
    }

    pub fn len(&self) -> usize {
        self.shapes.len()
    }

    pub fn is_empty(&self) -> bool {
        self.shapes.is_empty()
    }

    pub fn shapes(&self) -> &[Shape] {
        &self.shapes
    }

    pub fn iter(&self) -> std::slice::Iter<'_, Shape> {
        self.shapes.iter()
    }

    /// The shape at `index`; negative indices count from the end (`-1` is the last shape).
    pub fn get(&self, index: i64) -> Result<Shape> {
        let len = self.len();
        let resolved = if index < 0 { len as i64 + index } else { index };
        if resolved < 0 || resolved >= len as i64 {
            return Err(Error::IndexOutOfRange { index, len });
        }
        Ok(self.shapes[resolved as usize].clone())
    }

    pub fn first(&self) -> Result<Shape> {
        self.shapes.first().cloned().ok_or_else(|| Error::EmptySelection("first()".into()))
    }

    pub fn last(&self) -> Result<Shape> {
        self.shapes.last().cloned().ok_or_else(|| Error::EmptySelection("last()".into()))
    }

    /// The only shape in the selection; fails unless there is exactly one.
    pub fn single(&self) -> Result<Shape> {
        match self.len() {
            1 => Ok(self.shapes[0].clone()),
            0 => Err(Error::EmptySelection("expected exactly one shape".into())),
            n => Err(Error::InvalidArgument(format!("expected exactly one shape, found {n}"))),
        }
    }

    /// Filters by a selector string such as `">Z"` or `"|X and %LINE"`. See
    /// [`crate::selector`] for the syntax.
    pub fn select(&self, selector: &str) -> Result<Selection> {
        selector::parse(selector)?.apply(self)
    }

    /// Keeps the shapes for which `predicate` returns `true`.
    pub fn filter(&self, mut predicate: impl FnMut(&Shape) -> Result<bool>) -> Result<Selection> {
        let mut kept = Vec::new();
        for shape in self.iter() {
            if predicate(shape)? {
                kept.push(shape.clone());
            }
        }
        Ok(Selection::new(kept))
    }

    /// Sorts by a numeric key, ascending. NaN keys sort last.
    pub fn sort_by_key(&self, mut key: impl FnMut(&Shape) -> Result<f64>) -> Result<Selection> {
        let mut keyed =
            self.iter().map(|s| Ok((key(s)?, s.clone()))).collect::<Result<Vec<_>>>()?;
        keyed.sort_by(|a, b| a.0.total_cmp(&b.0));
        Ok(Selection::new(keyed.into_iter().map(|(_, s)| s).collect()))
    }

    fn projections(&self, dir: DVec3) -> Result<Vec<f64>> {
        let dir = normalize(dir)?;
        self.iter().map(|s| Ok(s.center()?.dot(dir))).collect()
    }

    /// The shapes whose centers are farthest along `dir` (all of them, within tolerance).
    pub fn farthest(&self, dir: DVec3) -> Result<Selection> {
        self.nth_farthest(dir, 0)
    }

    /// The shapes whose centers are nearest along `dir`, i.e. farthest along `-dir`.
    pub fn nearest(&self, dir: DVec3) -> Result<Selection> {
        self.nth_farthest(-dir, 0)
    }

    /// Groups the shapes into levels along `dir` (shapes whose centers project within
    /// tolerance of each other share a level), ordered from farthest to nearest, and returns
    /// level `n`. Negative `n` counts from the nearest level. Out-of-range levels are empty.
    pub fn nth_farthest(&self, dir: DVec3, n: i64) -> Result<Selection> {
        let projections = self.projections(dir)?;
        let mut order: Vec<usize> = (0..self.len()).collect();
        order.sort_by(|&a, &b| projections[b].total_cmp(&projections[a]));

        let mut levels: Vec<Vec<usize>> = Vec::new();
        for index in order {
            match levels.last_mut() {
                Some(level) if (projections[level[0]] - projections[index]).abs() <= TOLERANCE => {
                    level.push(index)
                },
                _ => levels.push(vec![index]),
            }
        }

        let resolved = if n < 0 { levels.len() as i64 + n } else { n };
        let Some(level) = usize::try_from(resolved).ok().and_then(|i| levels.get(i)) else {
            return Ok(Selection::default());
        };
        let mut level = level.clone();
        level.sort_unstable();
        Ok(Selection::new(level.into_iter().map(|i| self.shapes[i].clone()).collect()))
    }

    /// The direction associated with a shape for direction filters: the normal of a planar
    /// face or the direction of a straight edge. Other shapes have none.
    pub(crate) fn characteristic_direction(shape: &Shape) -> Option<DVec3> {
        match shape.geom_type() {
            Ok("plane") => shape.normal().ok(),
            Ok("line") => shape.line_direction().ok(),
            _ => None,
        }
    }

    fn filter_direction(&self, dir: DVec3, keep: impl Fn(f64) -> bool) -> Result<Selection> {
        let dir = normalize(dir)?;
        self.filter(|s| Ok(Self::characteristic_direction(s).is_some_and(|d| keep(d.dot(dir)))))
    }

    /// Planar faces whose normal, or straight edges whose direction, is parallel to `dir`
    /// (either sense).
    pub fn parallel_to(&self, dir: DVec3) -> Result<Selection> {
        self.filter_direction(dir, |dot| dot.abs() >= 1.0 - TOLERANCE)
    }

    /// Planar faces whose normal, or straight edges whose direction, is perpendicular to `dir`.
    pub fn perpendicular_to(&self, dir: DVec3) -> Result<Selection> {
        self.filter_direction(dir, |dot| dot.abs() <= TOLERANCE)
    }

    /// Planar faces whose normal, or straight edges whose direction, points along `dir`.
    pub fn facing(&self, dir: DVec3) -> Result<Selection> {
        self.filter_direction(dir, |dot| dot >= 1.0 - TOLERANCE)
    }

    /// Edges or faces of the given geometry type (see [`Shape::geom_type`]), case-insensitive.
    pub fn of_type(&self, geom_type: &str) -> Result<Selection> {
        let wanted = geom_type.trim().to_ascii_lowercase();
        self.filter(|s| Ok(s.geom_type().is_ok_and(|t| t == wanted)))
    }

    fn contains(&self, shape: &Shape) -> bool {
        self.iter().any(|s| s.is_same(shape))
    }

    /// Shapes in either selection (without duplicates), in order.
    pub fn union(&self, other: &Selection) -> Selection {
        let mut shapes = Vec::with_capacity(self.len() + other.len());
        for shape in self.iter().chain(other.iter()) {
            if !shapes.iter().any(|s: &Shape| s.is_same(shape)) {
                shapes.push(shape.clone());
            }
        }
        Selection::new(shapes)
    }

    /// Shapes in both selections.
    pub fn intersect(&self, other: &Selection) -> Selection {
        Selection::new(self.iter().filter(|s| other.contains(s)).cloned().collect())
    }

    /// Shapes in this selection but not in `other`.
    pub fn subtract(&self, other: &Selection) -> Selection {
        Selection::new(self.iter().filter(|s| !other.contains(s)).cloned().collect())
    }

    /// All shapes grouped into one compound.
    pub fn to_compound(&self) -> Result<Shape> {
        Shape::compound(self.shapes())
    }
}

impl IntoIterator for Selection {
    type IntoIter = std::vec::IntoIter<Shape>;
    type Item = Shape;

    fn into_iter(self) -> Self::IntoIter {
        Rc::try_unwrap(self.shapes).unwrap_or_else(|shared| (*shared).clone()).into_iter()
    }
}

impl<'a> IntoIterator for &'a Selection {
    type IntoIter = std::slice::Iter<'a, Shape>;
    type Item = &'a Shape;

    fn into_iter(self) -> Self::IntoIter {
        self.iter()
    }
}

impl FromIterator<Shape> for Selection {
    fn from_iter<T: IntoIterator<Item = Shape>>(iter: T) -> Self {
        Selection::new(iter.into_iter().collect())
    }
}

impl fmt::Debug for Selection {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{self}")
    }
}

impl fmt::Display for Selection {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut kinds: Vec<(&str, usize)> = Vec::new();
        for shape in self.iter() {
            let name = shape.shape_type().name();
            match kinds.iter_mut().find(|(k, _)| *k == name) {
                Some((_, count)) => *count += 1,
                None => kinds.push((name, 1)),
            }
        }
        let summary: Vec<String> = kinds.iter().map(|(k, n)| format!("{n} {k}")).collect();
        write!(f, "Selection([{}])", summary.join(", "))
    }
}
