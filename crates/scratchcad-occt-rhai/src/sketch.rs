//! [`Sketch`]: a chainable 2D path builder on a [`Plane`].

use crate::{
    error::{invalid, Result},
    math::{require_finite, Plane, EPSILON},
    shape::Shape,
};
use glam::DVec2;
use std::{fmt, rc::Rc};

#[derive(Debug, Clone, Copy, PartialEq)]
enum Segment {
    Line { end: DVec2 },
    Arc { mid: DVec2, end: DVec2 },
}

impl Segment {
    fn end(&self) -> DVec2 {
        match self {
            Segment::Line { end } | Segment::Arc { end, .. } => *end,
        }
    }
}

/// A 2D path of lines and arcs, drawn in the coordinates of a [`Plane`].
///
/// Every method returns a new sketch (the segment list is shared until modified), so a sketch
/// can be built in one chain and partial sketches can be reused:
///
/// ```no_run
/// # use scratchcad_occt_rhai::{Sketch, Plane};
/// let profile = Sketch::new(Plane::xy())
///     .line_to(10.0, 0.0)?
///     .line_to(10.0, 5.0)?
///     .arc_to(5.0, 8.0, 0.0, 5.0)?
///     .close()?;
/// # Ok::<(), scratchcad_occt_rhai::Error>(())
/// ```
#[derive(Debug, Clone, PartialEq)]
pub struct Sketch {
    plane: Plane,
    start: DVec2,
    segments: Rc<Vec<Segment>>,
}

impl Sketch {
    /// An empty sketch whose pen starts at the plane's origin.
    pub fn new(plane: Plane) -> Self {
        Self { plane, start: DVec2::ZERO, segments: Rc::new(Vec::new()) }
    }

    pub fn plane(&self) -> Plane {
        self.plane
    }

    /// The current pen position, in plane coordinates.
    pub fn position(&self) -> DVec2 {
        self.segments.last().map(Segment::end).unwrap_or(self.start)
    }

    /// The number of segments drawn so far.
    pub fn segment_count(&self) -> usize {
        self.segments.len()
    }

    fn checked_point(x: f64, y: f64) -> Result<DVec2> {
        Ok(DVec2::new(require_finite(x, "sketch x")?, require_finite(y, "sketch y")?))
    }

    fn push(&self, segment: Segment) -> Result<Self> {
        if segment.end().distance(self.position()) < EPSILON {
            return Err(invalid("sketch segment has zero length"));
        }
        let mut segments = (*self.segments).clone();
        segments.push(segment);
        Ok(Self { segments: Rc::new(segments), ..self.clone() })
    }

    /// Moves the pen without drawing. Only allowed before the first segment.
    pub fn move_to(&self, x: f64, y: f64) -> Result<Self> {
        if !self.segments.is_empty() {
            return Err(invalid(
                "move_to is only allowed before drawing; start a new sketch instead",
            ));
        }
        Ok(Self { start: Self::checked_point(x, y)?, ..self.clone() })
    }

    /// A line to an absolute position.
    pub fn line_to(&self, x: f64, y: f64) -> Result<Self> {
        self.push(Segment::Line { end: Self::checked_point(x, y)? })
    }

    /// A line relative to the current position.
    pub fn line(&self, dx: f64, dy: f64) -> Result<Self> {
        let delta = Self::checked_point(dx, dy)?;
        self.push(Segment::Line { end: self.position() + delta })
    }

    /// A horizontal line of length `dx` (negative goes left).
    pub fn hline(&self, dx: f64) -> Result<Self> {
        self.line(dx, 0.0)
    }

    /// A vertical line of length `dy` (negative goes down).
    pub fn vline(&self, dy: f64) -> Result<Self> {
        self.line(0.0, dy)
    }

    /// A horizontal line to the absolute x coordinate.
    pub fn hline_to(&self, x: f64) -> Result<Self> {
        self.line_to(x, self.position().y)
    }

    /// A vertical line to the absolute y coordinate.
    pub fn vline_to(&self, y: f64) -> Result<Self> {
        self.line_to(self.position().x, y)
    }

    /// A line of the given length at `degrees` counter-clockwise from the plane's X axis.
    pub fn polar_line(&self, length: f64, degrees: f64) -> Result<Self> {
        let angle = require_finite(degrees, "angle")?.to_radians();
        self.line(length * angle.cos(), length * angle.sin())
    }

    /// A circular arc through `(mid_x, mid_y)` ending at `(x, y)`.
    pub fn arc_to(&self, mid_x: f64, mid_y: f64, x: f64, y: f64) -> Result<Self> {
        let mid = Self::checked_point(mid_x, mid_y)?;
        let end = Self::checked_point(x, y)?;
        let start = self.position();
        let cross = (mid - start).perp_dot(end - start);
        if cross.abs() < EPSILON {
            return Err(invalid("arc points must not be collinear"));
        }
        self.push(Segment::Arc { mid, end })
    }

    fn edges(&self, segments: &[Segment]) -> Result<Vec<Shape>> {
        let mut position = self.start;
        let mut edges = Vec::with_capacity(segments.len());
        for segment in segments {
            let start = self.plane.to_world(position);
            edges.push(match segment {
                Segment::Line { end } => Shape::line(start, self.plane.to_world(*end))?,
                Segment::Arc { mid, end } => {
                    Shape::arc(start, self.plane.to_world(*mid), self.plane.to_world(*end))?
                },
            });
            position = segment.end();
        }
        Ok(edges)
    }

    /// The drawn path as an open wire.
    pub fn wire(&self) -> Result<Shape> {
        if self.segments.is_empty() {
            return Err(invalid("cannot make a wire from an empty sketch"));
        }
        Shape::wire_from(&self.edges(&self.segments)?)
    }

    /// The path closed back to its starting point, as a closed wire. A closing line is added
    /// unless the pen is already at the start.
    pub fn close(&self) -> Result<Shape> {
        let mut segments = (*self.segments).clone();
        if self.position().distance(self.start) > EPSILON {
            segments.push(Segment::Line { end: self.start });
        }
        let all_lines = segments.iter().all(|s| matches!(s, Segment::Line { .. }));
        if segments.len() < 2 || (segments.len() < 3 && all_lines) {
            return Err(invalid(
                "a closed sketch needs at least 3 lines (or 2 segments with an arc)",
            ));
        }
        Shape::wire_from(&self.edges(&segments)?)
    }

    /// The closed path as a planar face.
    pub fn face(&self) -> Result<Shape> {
        Shape::face_from(&self.close()?)
    }
}

impl fmt::Display for Sketch {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let p = self.position();
        write!(f, "Sketch({} segments, at ({}, {}))", self.segments.len(), p.x, p.y)
    }
}
