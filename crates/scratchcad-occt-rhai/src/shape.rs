//! The [`Shape`] handle and every operation on it.

use crate::{
    cancel::{failed, progress},
    error::{invalid, Error, Result},
    math::{
        self, axis1, axis2, fmt_vec, from_pnt, from_vec, point, require_finite,
        require_non_negative, require_positive, vector, Plane, EPSILON,
    },
    selection::Selection,
};
use cxx::UniquePtr;
use glam::{DVec2, DVec3};
use scratchcad_occt_sys as ffi;
use std::{fmt, rc::Rc};

/// The topological type of a [`Shape`].
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum ShapeType {
    Vertex,
    Edge,
    Wire,
    Face,
    Shell,
    Solid,
    CompSolid,
    Compound,
}

impl ShapeType {
    pub const ALL: [ShapeType; 8] = [
        ShapeType::Vertex,
        ShapeType::Edge,
        ShapeType::Wire,
        ShapeType::Face,
        ShapeType::Shell,
        ShapeType::Solid,
        ShapeType::CompSolid,
        ShapeType::Compound,
    ];

    /// The lowercase name used in scripts and error messages, e.g. `"face"`.
    pub fn name(self) -> &'static str {
        match self {
            ShapeType::Vertex => "vertex",
            ShapeType::Edge => "edge",
            ShapeType::Wire => "wire",
            ShapeType::Face => "face",
            ShapeType::Shell => "shell",
            ShapeType::Solid => "solid",
            ShapeType::CompSolid => "compsolid",
            ShapeType::Compound => "compound",
        }
    }

    /// Parses a name produced by [`ShapeType::name`] (case-insensitive).
    pub fn parse(name: &str) -> Result<Self> {
        let lower = name.trim().to_ascii_lowercase();
        Self::ALL
            .into_iter()
            .find(|kind| kind.name() == lower)
            .ok_or_else(|| invalid(format!("unknown shape type {name:?}")))
    }

    pub(crate) fn to_ffi(self) -> ffi::top_abs::TopAbs_ShapeEnum {
        use ffi::top_abs::TopAbs_ShapeEnum as E;
        match self {
            ShapeType::Vertex => E::TopAbs_VERTEX,
            ShapeType::Edge => E::TopAbs_EDGE,
            ShapeType::Wire => E::TopAbs_WIRE,
            ShapeType::Face => E::TopAbs_FACE,
            ShapeType::Shell => E::TopAbs_SHELL,
            ShapeType::Solid => E::TopAbs_SOLID,
            ShapeType::CompSolid => E::TopAbs_COMPSOLID,
            ShapeType::Compound => E::TopAbs_COMPOUND,
        }
    }

    pub(crate) fn from_ffi(kind: ffi::top_abs::TopAbs_ShapeEnum) -> Self {
        use ffi::top_abs::TopAbs_ShapeEnum as E;
        match kind {
            E::TopAbs_VERTEX => ShapeType::Vertex,
            E::TopAbs_EDGE => ShapeType::Edge,
            E::TopAbs_WIRE => ShapeType::Wire,
            E::TopAbs_FACE => ShapeType::Face,
            E::TopAbs_SHELL => ShapeType::Shell,
            E::TopAbs_SOLID => ShapeType::Solid,
            E::TopAbs_COMPSOLID => ShapeType::CompSolid,
            // TopAbs_SHAPE is only reported for null shapes, which `Shape` never holds.
            _ => ShapeType::Compound,
        }
    }
}

impl fmt::Display for ShapeType {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.name())
    }
}

/// An immutable, cheaply clonable handle to an OpenCASCADE shape.
///
/// Cloning a `Shape` only bumps a reference count. Every operation returns a *new* shape, which
/// makes shapes safe to share between script variables and lets calls be chained:
/// `Shape::make_box(10.0, 10.0, 10.0)?.fillet_all(1.0)?.translate(..)`.
///
/// A single type covers every topological kind (vertex, edge, wire, face, shell, solid,
/// compound); operations that need a specific kind check it at runtime and return
/// [`Error::WrongShapeType`]. A `Shape` is never null.
///
/// # Threads
///
/// `Shape` is neither `Send` nor `Sync`. OpenCASCADE shapes share sub-shapes (an extrusion
/// shares its profile, a fillet the untouched faces of its input), and many of its algorithms
/// annotate the sub-shapes of their *inputs* in place: they attach parameter curves to edges and
/// raise vertex and edge tolerances. Two threads working on shapes that share sub-shapes would
/// race on that data. To hand a shape to another thread, [`detach`](Shape::detach) it: that
/// makes a deep copy sharing nothing with any other shape. (For the same reason, do not enable
/// Rhai's `sync` feature: it requires every registered type to be `Send + Sync`.)
#[derive(Clone)]
pub struct Shape {
    inner: Rc<UniquePtr<ffi::topo_ds::TopoDS_Shape>>,
}

/// A deep copy of a [`Shape`] that can be moved to another thread, where
/// [`attach`](DetachedShape::attach) turns it back into a `Shape`.
///
/// It shares no topology or geometry with any other shape, so nothing another thread does can
/// touch it. It cannot be cloned or used until it is attached.
pub struct DetachedShape(UniquePtr<ffi::topo_ds::TopoDS_Shape>);

// SAFETY: `Shape::detach` builds the shape with `BRepBuilderAPI_Copy` copying geometry, so it
// shares no topology, geometry or triangulation with any shape that stays behind. What it does
// share (location datums, type descriptors) is immutable after construction and
// reference-counted with atomic counters (`Standard_Transient::myRefCount_` is a
// `std::atomic_int`). `DetachedShape` gives no access to the shape until `attach` moves it into
// a thread-local `Shape`.
unsafe impl Send for DetachedShape {}

impl DetachedShape {
    /// The shape, now owned by the current thread. No copy is made.
    pub fn attach(self) -> Shape {
        // `detach` only wraps non-null shapes.
        Shape { inner: Rc::new(self.0) }
    }
}

impl fmt::Debug for DetachedShape {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str("DetachedShape")
    }
}

/// Where a point lies relative to a solid; see [`Shape::classify`].
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum PointLocation {
    Inside,
    Outside,
    /// On the boundary, within [`CLASSIFY_TOLERANCE`].
    OnBoundary,
}

impl PointLocation {
    /// The name used in scripts: `"inside"`, `"outside"` or `"on"`.
    pub fn name(self) -> &'static str {
        match self {
            PointLocation::Inside => "inside",
            PointLocation::Outside => "outside",
            PointLocation::OnBoundary => "on",
        }
    }
}

impl fmt::Display for PointLocation {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.name())
    }
}

/// How close to a solid's boundary a point counts as [on it](PointLocation::OnBoundary).
pub const CLASSIFY_TOLERANCE: f64 = 1e-7;

impl Shape {
    // ---------------------------------------------------------------------------------------
    // Construction from raw OCCT data
    // ---------------------------------------------------------------------------------------

    /// Wraps a copy of a raw OCCT shape. Fails for null shapes.
    pub fn from_raw(shape: &ffi::topo_ds::TopoDS_Shape) -> Result<Self> {
        Self::from_unique(ffi::topo_ds::TopoDS_Shape_to_owned(shape))
    }

    /// Wraps the result of a modeling algorithm. OCCT often returns a compound holding a single
    /// shape; scripts are simpler when that shape is returned directly, so such compounds are
    /// unwrapped.
    pub(crate) fn from_algorithm(shape: &ffi::topo_ds::TopoDS_Shape) -> Result<Self> {
        Ok(Self::from_raw(shape)?.unwrap_single())
    }

    /// The only top-level content of a compound holding exactly one shape, or `self`.
    pub fn unwrap_single(self) -> Self {
        if !self.is(ShapeType::Compound) || self.children() != 1 {
            return self;
        }
        // The child is the highest-dimensional sub-shape, provided there is exactly one.
        for kind in &ShapeType::ALL[..7].iter().rev().copied().collect::<Vec<_>>() {
            let found = self.subshapes(*kind);
            match found.len() {
                0 => continue,
                1 => return found.shapes()[0].clone(),
                _ => return self,
            }
        }
        self
    }

    pub(crate) fn from_unique(shape: UniquePtr<ffi::topo_ds::TopoDS_Shape>) -> Result<Self> {
        if shape.is_null() || shape.IsNull() {
            return Err(Error::OperationFailed("building the shape"));
        }
        Ok(Self { inner: Rc::new(shape) })
    }

    /// The underlying OCCT shape, for use with `scratchcad-occt-sys` directly.
    pub fn raw(&self) -> &ffi::topo_ds::TopoDS_Shape {
        &self.inner
    }

    /// A copy with its own topology and geometry, sharing nothing with this shape. Sub-shapes
    /// keep their exploration order. Triangulations are not copied.
    pub fn deep_copy(&self) -> Result<Self> {
        Self::from_unique(self.copy_raw()?)
    }

    /// A deep copy that can be moved to another thread; see [`DetachedShape`].
    pub fn detach(&self) -> Result<DetachedShape> {
        Ok(DetachedShape(self.copy_raw()?))
    }

    fn copy_raw(&self) -> Result<UniquePtr<Raw>> {
        let copy = ffi::b_rep_builder_api::BRepBuilderAPI_copy_shape(self.raw())?;
        if copy.is_null() || copy.IsNull() {
            return Err(Error::OperationFailed("copying the shape"));
        }
        Ok(copy)
    }

    // ---------------------------------------------------------------------------------------
    // Type checks and down-casts
    // ---------------------------------------------------------------------------------------

    pub fn shape_type(&self) -> ShapeType {
        ShapeType::from_ffi(self.inner.ShapeType())
    }

    pub fn is(&self, kind: ShapeType) -> bool {
        self.shape_type() == kind
    }

    pub(crate) fn expect(&self, kind: ShapeType) -> Result<()> {
        let actual = self.shape_type();
        if actual == kind {
            Ok(())
        } else {
            Err(Error::WrongShapeType { expected: kind.name(), actual: actual.name() })
        }
    }

    pub(crate) fn edge(&self) -> Result<&ffi::topo_ds::TopoDS_Edge> {
        self.expect(ShapeType::Edge)?;
        Ok(ffi::topo_ds::TopoDS::Edge(self.raw())?)
    }

    pub(crate) fn wire(&self) -> Result<&ffi::topo_ds::TopoDS_Wire> {
        self.expect(ShapeType::Wire)?;
        Ok(ffi::topo_ds::TopoDS::Wire(self.raw())?)
    }

    pub(crate) fn face(&self) -> Result<&ffi::topo_ds::TopoDS_Face> {
        self.expect(ShapeType::Face)?;
        Ok(ffi::topo_ds::TopoDS::Face(self.raw())?)
    }

    pub(crate) fn vertex(&self) -> Result<&ffi::topo_ds::TopoDS_Vertex> {
        self.expect(ShapeType::Vertex)?;
        Ok(ffi::topo_ds::TopoDS::Vertex(self.raw())?)
    }

    /// Whether both handles refer to the same underlying topology (ignoring orientation).
    pub fn is_same(&self, other: &Shape) -> bool {
        self.inner.IsSame(other.raw())
    }

    // ---------------------------------------------------------------------------------------
    // Primitives
    // ---------------------------------------------------------------------------------------

    /// A box with one corner at the origin, extending into the positive axes.
    pub fn make_box(dx: f64, dy: f64, dz: f64) -> Result<Self> {
        Self::box_from_corners(DVec3::ZERO, DVec3::new(dx, dy, dz))
    }

    /// A box with the given dimensions, centered on the origin.
    pub fn box_centered(dx: f64, dy: f64, dz: f64) -> Result<Self> {
        let half = DVec3::new(dx, dy, dz) / 2.0;
        Self::box_from_corners(-half, half)
    }

    /// A box spanning two opposite corners (in any order).
    pub fn box_from_corners(a: DVec3, b: DVec3) -> Result<Self> {
        let min = a.min(b);
        let size = a.max(b) - min;
        for (value, name) in
            [(size.x, "box x size"), (size.y, "box y size"), (size.z, "box z size")]
        {
            require_positive(value, name)?;
        }
        let mut make =
            ffi::b_rep_prim_api::BRepPrimAPI_MakeBox_new(&point(min), size.x, size.y, size.z)?;
        Self::from_raw(make.pin_mut().Shape()?)
    }

    /// A cube with side `size`, one corner at the origin.
    pub fn cube(size: f64) -> Result<Self> {
        Self::make_box(size, size, size)
    }

    /// A cylinder standing on the XY plane, centered on the Z axis.
    pub fn cylinder(radius: f64, height: f64) -> Result<Self> {
        Self::cylinder_at(DVec3::ZERO, DVec3::Z, radius, height)
    }

    /// A cylinder whose base circle is centered at `base`, extending `height` along `axis`.
    pub fn cylinder_at(base: DVec3, axis: DVec3, radius: f64, height: f64) -> Result<Self> {
        require_positive(radius, "cylinder radius")?;
        require_positive(height, "cylinder height")?;
        let mut make = ffi::b_rep_prim_api::BRepPrimAPI_MakeCylinder_new(
            &*axis2(base, axis)?,
            radius,
            height,
        )?;
        Self::from_raw(make.pin_mut().Shape()?)
    }

    /// A sphere centered on the origin.
    pub fn sphere(radius: f64) -> Result<Self> {
        Self::sphere_at(DVec3::ZERO, radius)
    }

    pub fn sphere_at(center: DVec3, radius: f64) -> Result<Self> {
        require_positive(radius, "sphere radius")?;
        let mut make = ffi::b_rep_prim_api::BRepPrimAPI_MakeSphere_new(
            &*axis2(center, DVec3::Z)?,
            radius,
            std::f64::consts::TAU,
        )?;
        Self::from_raw(make.pin_mut().Shape()?)
    }

    /// A cone (or truncated cone) standing on the XY plane around the Z axis. One of the radii
    /// may be zero, but they must differ.
    pub fn cone(bottom_radius: f64, top_radius: f64, height: f64) -> Result<Self> {
        require_non_negative(bottom_radius, "cone bottom radius")?;
        require_non_negative(top_radius, "cone top radius")?;
        require_positive(height, "cone height")?;
        if (bottom_radius - top_radius).abs() < EPSILON {
            return Err(invalid("cone radii must differ (use a cylinder instead)"));
        }
        let mut make = ffi::b_rep_prim_api::BRepPrimAPI_MakeCone_new(
            &*axis2(DVec3::ZERO, DVec3::Z)?,
            bottom_radius,
            top_radius,
            height,
            std::f64::consts::TAU,
        )?;
        Self::from_raw(make.pin_mut().Shape()?)
    }

    /// A torus around the Z axis. `major_radius` is the distance from the axis to the center of
    /// the tube, `minor_radius` the radius of the tube.
    pub fn torus(major_radius: f64, minor_radius: f64) -> Result<Self> {
        require_positive(major_radius, "torus major radius")?;
        require_positive(minor_radius, "torus minor radius")?;
        // OpenCASCADE makes a torus whose tube is at least as wide as its ring, which crosses
        // itself, and its checker passes it.
        if minor_radius >= major_radius {
            return Err(invalid(format!(
                "a torus's minor radius must be smaller than its major radius, got {minor_radius} \
                 and {major_radius}: a tube that wide crosses itself at the axis"
            )));
        }
        let mut make = ffi::b_rep_prim_api::BRepPrimAPI_MakeTorus_new(
            &*axis2(DVec3::ZERO, DVec3::Z)?,
            major_radius,
            minor_radius,
            0.0,
            std::f64::consts::TAU,
            std::f64::consts::TAU,
        )?;
        Self::from_raw(make.pin_mut().Shape()?)
    }

    // ---------------------------------------------------------------------------------------
    // Vertices, edges, wires, faces, compounds
    // ---------------------------------------------------------------------------------------

    pub fn vertex_at(position: DVec3) -> Result<Self> {
        if !position.is_finite() {
            return Err(invalid(format!(
                "vertex position must be finite, got {}",
                fmt_vec(position)
            )));
        }
        let mut make = ffi::b_rep_builder_api::BRepBuilderAPI_MakeVertex_gp_Pnt(&point(position))?;
        Self::from_raw(ffi::topo_ds::cast_vertex_to_shape(make.pin_mut().Vertex()?))
    }

    /// A straight edge between two distinct points.
    pub fn line(start: DVec3, end: DVec3) -> Result<Self> {
        if !start.is_finite() || !end.is_finite() || start.distance(end) < EPSILON {
            return Err(invalid(format!(
                "a line needs two distinct finite points, got {} and {}",
                fmt_vec(start),
                fmt_vec(end)
            )));
        }
        let mut make = ffi::b_rep_builder_api::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(
            &point(start),
            &point(end),
        )?;
        if !make.IsDone() {
            return Err(Error::OperationFailed("making a line"));
        }
        Self::from_raw(ffi::topo_ds::cast_edge_to_shape(make.pin_mut().Edge()?))
    }

    /// A circular arc edge from `start` through `mid` to `end`.
    pub fn arc(start: DVec3, mid: DVec3, end: DVec3) -> Result<Self> {
        let make =
            ffi::gc::GC_MakeArcOfCircle_point_point_point(&point(start), &point(mid), &point(end))?;
        let arc = ffi::gc::GC_MakeArcOfCircle_Value(&make).map_err(|_| {
            invalid(format!(
                "cannot make an arc through {}, {} and {} (are they collinear?)",
                fmt_vec(start),
                fmt_vec(mid),
                fmt_vec(end)
            ))
        })?;
        let curve = ffi::geom::new_HandleGeomCurve_from_HandleGeom_TrimmedCurve(&arc);
        Self::edge_from_curve(&curve, "making an arc")
    }

    fn edge_from_curve(curve: &ffi::geom::Handle_Geom_Curve, what: &'static str) -> Result<Self> {
        let mut make = ffi::b_rep_builder_api::BRepBuilderAPI_MakeEdge_HandleGeomCurve(curve)?;
        if !make.IsDone() {
            return Err(Error::OperationFailed(what));
        }
        Self::from_raw(ffi::topo_ds::cast_edge_to_shape(make.pin_mut().Edge()?))
    }

    /// A full circle as a closed edge. It starts (its seam is) on the side of the center
    /// toward +Z when the normal is within 60 degrees of horizontal, and toward +X otherwise, so
    /// circles whose normals differ a little start in nearly the same place, and lofts through
    /// them do not twist: circles along a helix around Z all start on top. (OpenCASCADE's own
    /// choice jumps to the opposite side as the normal turns.)
    pub fn circle_edge(center: DVec3, normal: DVec3, radius: f64) -> Result<Self> {
        let n = crate::math::normalize(normal)?;
        let reference = if n.z.abs() < 0.5 { DVec3::Z } else { DVec3::X };
        let plane = Plane::with_x_dir(center, n, reference)?;
        Self::circle_edge_around(&*plane.to_ax2()?, radius)
    }

    fn circle_edge_around(axis: &ffi::gp::gp_Ax2, radius: f64) -> Result<Self> {
        require_positive(radius, "circle radius")?;
        let circle = ffi::gp::gp_Circ_new(axis, radius)?;
        let mut make = ffi::b_rep_builder_api::BRepBuilderAPI_MakeEdge_circle(&circle)?;
        if !make.IsDone() {
            return Err(Error::OperationFailed("making a circle"));
        }
        Self::from_raw(ffi::topo_ds::cast_edge_to_shape(make.pin_mut().Edge()?))
    }

    /// A full circle as a closed wire, ready to be turned into a face or extruded.
    pub fn circle(center: DVec3, normal: DVec3, radius: f64) -> Result<Self> {
        Self::wire_from(&[Self::circle_edge(center, normal, radius)?])
    }

    /// A circle of the given radius centered on a plane's origin, starting on its X axis.
    pub fn circle_on(plane: &Plane, radius: f64) -> Result<Self> {
        Self::wire_from(&[Self::circle_edge_around(&*plane.to_ax2()?, radius)?])
    }

    /// A smooth B-spline edge through all points. A `closed` spline loops back to the start.
    pub fn spline(points: &[DVec3], closed: bool) -> Result<Self> {
        let mut points = points.to_vec();
        if closed && points.len() > 2 && points[0].distance(points[points.len() - 1]) < EPSILON {
            points.pop();
        }
        if points.len() < 2 {
            return Err(invalid("a spline needs at least 2 points"));
        }
        let array = Self::point_array(&points)?;
        let failed =
            |_| invalid("cannot interpolate a spline through these points (are they distinct?)");
        let mut interpolate =
            ffi::geom_api::GeomAPI_Interpolate_new(&array, closed, 1e-7).map_err(failed)?;
        interpolate.pin_mut().Perform().map_err(failed)?;
        let curve = ffi::geom_api::GeomAPI_Interpolate_Curve(&interpolate).map_err(failed)?;
        let curve = ffi::geom::new_HandleGeomCurve_from_HandleGeom_BSplineCurve(&curve);
        Self::edge_from_curve(&curve, "making a spline")
    }

    /// A Bézier curve edge with the given control points.
    pub fn bezier(control_points: &[DVec3]) -> Result<Self> {
        if control_points.len() < 2 {
            return Err(invalid("a Bezier curve needs at least 2 control points"));
        }
        let mut array = ffi::t_col_gp::TColgp_HArray1OfPnt_new(1, control_points.len() as i32)?;
        for (i, p) in control_points.iter().enumerate() {
            array.pin_mut().SetValue(i as i32 + 1, &point(*p))?;
        }
        let curve = ffi::geom::Geom_BezierCurve_new_points(&array)?;
        let curve = ffi::geom::Geom_BezierCurve_to_handle(curve);
        let curve = ffi::geom::new_HandleGeomCurve_from_HandleGeom_BezierCurve(&curve);
        Self::edge_from_curve(&curve, "making a Bezier curve")
    }

    fn point_array(
        points: &[DVec3],
    ) -> Result<UniquePtr<ffi::t_col_gp::Handle_TColgp_HArray1OfPnt>> {
        let mut array = ffi::t_col_gp::TColgp_HArray1OfPnt_new(1, points.len() as i32)?;
        for (i, p) in points.iter().enumerate() {
            if !p.is_finite() {
                return Err(invalid(format!("point {} is not finite", fmt_vec(*p))));
            }
            array.pin_mut().SetValue(i as i32 + 1, &point(*p))?;
        }
        Ok(ffi::t_col_gp::new_HandleTColgpHArray1OfPnt_from_TColgpHArray1OfPnt(array))
    }

    /// An open wire of straight segments through the points.
    pub fn polyline(points: &[DVec3]) -> Result<Self> {
        if points.len() < 2 {
            return Err(invalid("a polyline needs at least 2 points"));
        }
        let edges = points
            .windows(2)
            .map(|pair| Self::line(pair[0], pair[1]))
            .collect::<Result<Vec<_>>>()?;
        Self::wire_from(&edges)
    }

    /// A closed wire of straight segments through the points (the closing segment is added
    /// automatically unless the last point equals the first). Points that all lie at one height
    /// are taken counter-clockwise seen from +Z, as [`polygon_on`](Self::polygon_on) takes them
    /// in the XY plane, so a face made from them faces up whichever way round they were listed.
    pub fn polygon(points: &[DVec3]) -> Result<Self> {
        if let Some(first) = points.first() {
            if points.iter().all(|p| (p.z - first.z).abs() < EPSILON) {
                let plane = Plane::xy().translated(DVec3::new(0.0, 0.0, first.z));
                let flat: Vec<DVec2> = points.iter().map(|p| p.truncate()).collect();
                return Self::polygon_on(&plane, &flat);
            }
        }
        Self::polygon_through(points)
    }

    fn polygon_through(points: &[DVec3]) -> Result<Self> {
        let mut points = points.to_vec();
        if points.len() > 1 && points[0].distance(points[points.len() - 1]) < EPSILON {
            points.pop();
        }
        if points.len() < 3 {
            return Err(invalid("a polygon needs at least 3 distinct points"));
        }
        points.push(points[0]);
        Self::polyline(&points)
    }

    /// A polygon given in the coordinates of `plane`. It runs counter-clockwise in the plane
    /// (points listed clockwise are taken the other way round), so a face made from it faces
    /// along the plane's normal and `extrude(distance)` goes to the plane's positive side.
    pub fn polygon_on(plane: &Plane, points: &[DVec2]) -> Result<Self> {
        let mut points = points.to_vec();
        if points.len() > 1 && points[0].distance(points[points.len() - 1]) < EPSILON {
            points.pop();
        }
        if math::signed_area(&points) < 0.0 {
            points[1..].reverse();
        }
        Self::polygon_through(&points.iter().map(|p| plane.to_world(*p)).collect::<Vec<_>>())
    }

    /// A `width` × `height` rectangle centered on the plane's origin.
    pub fn rect_on(plane: &Plane, width: f64, height: f64) -> Result<Self> {
        require_positive(width, "rectangle width")?;
        require_positive(height, "rectangle height")?;
        let (w, h) = (width / 2.0, height / 2.0);
        Self::polygon_on(
            plane,
            &[DVec2::new(-w, -h), DVec2::new(w, -h), DVec2::new(w, h), DVec2::new(-w, h)],
        )
    }

    /// Connects edges and/or wires into a single wire. They must form a connected chain.
    pub fn wire_from(parts: &[Shape]) -> Result<Self> {
        if parts.is_empty() {
            return Err(invalid("a wire needs at least one edge"));
        }
        let mut make = ffi::b_rep_builder_api::BRepBuilderAPI_MakeWire_new();
        for part in parts {
            match part.shape_type() {
                ShapeType::Edge => make.pin_mut().add_edge(part.edge()?)?,
                ShapeType::Wire => make.pin_mut().add_wire(part.wire()?)?,
                other => {
                    return Err(Error::WrongShapeType {
                        expected: "edge or wire",
                        actual: other.name(),
                    })
                },
            }
        }
        if !make.IsDone() {
            return Err(invalid("the edges do not form a connected wire"));
        }
        Self::from_raw(make.pin_mut().Shape()?)
    }

    /// A planar face bounded by a closed wire. Faces are returned unchanged.
    pub fn face_from(boundary: &Shape) -> Result<Self> {
        match boundary.shape_type() {
            ShapeType::Face => Ok(boundary.clone()),
            ShapeType::Wire => {
                if !boundary.is_closed() {
                    return Err(invalid("a face needs a closed wire"));
                }
                let mut make =
                    ffi::b_rep_builder_api::BRepBuilderAPI_MakeFace_wire(boundary.wire()?, true)?;
                if !make.IsDone() {
                    return Err(invalid("cannot make a face: the wire is not planar"));
                }
                let face = Self::from_raw(make.pin_mut().Shape()?)?;
                // OpenCASCADE makes a face from an outline that crosses itself, and everything
                // built on it is invalid: say so here rather than when a fillet or mesh fails.
                if !face.is_valid() {
                    return Err(invalid(
                        "cannot make a face: the outline crosses or touches itself; check its \
                         points (with sketches, that no line runs back over an earlier one)",
                    ));
                }
                Ok(face)
            },
            ShapeType::Edge => Self::face_from(&Self::wire_from(std::slice::from_ref(boundary))?),
            other => Err(Error::WrongShapeType { expected: "wire or face", actual: other.name() }),
        }
    }

    /// A planar face with holes: each hole (a closed wire or face) is cut out of the face
    /// bounded by `outer`.
    pub fn face_with_holes(outer: &Shape, holes: &[Shape]) -> Result<Self> {
        let mut face = Self::face_from(outer)?;
        for hole in holes {
            face = face.cut(&Self::face_from(hole)?)?;
        }
        // The cut produces a compound holding the single resulting face.
        let faces = face.faces();
        match faces.len() {
            1 => faces.get(0),
            n => Err(invalid(format!(
                "the holes leave {n} faces rather than one: each hole must lie inside the outline, \
                 without touching it or another hole"
            ))),
        }
    }

    /// Groups shapes into a compound without merging them.
    pub fn compound(shapes: &[Shape]) -> Result<Self> {
        let builder = ffi::b_rep::BRep_Builder_new();
        let builder = ffi::b_rep::BRep_Builder_upcast_to_topods_builder(&builder);
        let mut compound = ffi::topo_ds::TopoDS_Compound_new();
        builder.MakeCompound(compound.pin_mut());
        let mut compound = ffi::topo_ds::TopoDS_Compound_as_shape(compound);
        for shape in shapes {
            builder.Add(compound.pin_mut(), shape.raw())?;
        }
        Self::from_unique(compound)
    }

    /// An empty compound.
    pub fn empty() -> Result<Self> {
        Self::compound(&[])
    }

    // ---------------------------------------------------------------------------------------
    // Booleans
    // ---------------------------------------------------------------------------------------

    /// Runs a boolean operation in OpenCASCADE's non-destructive mode, which leaves both
    /// arguments unmodified.
    ///
    /// A boolean can succeed and still return a wrong shape, which later operations then mangle
    /// or drop without an error. So its result is checked, and the boolean fails when the result
    /// is invalid, or when its volume shows the boolean went wrong (see
    /// [`volume_problem`](Self::volume_problem)). It fails too when the check can't be made:
    /// no result is returned unchecked.
    fn boolean(&self, other: &Shape, name: &'static str, run: BooleanFn) -> Result<UniquePtr<Raw>> {
        let mut warnings = String::new();
        let result = run(self.raw(), other.raw(), &progress(), &mut warnings)?;
        if result.is_null() {
            return Err(failed(name));
        }
        if !valid(&result) {
            let inputs_valid = self.is_valid() && other.is_valid();
            return Err(invalid(invalid_boolean(name, &warnings, inputs_valid)));
        }
        checked(name, self.volume_problem(other, name, &result))?;
        Ok(result)
    }

    /// What is wrong with a boolean's result whose volume no correct result could have: a fuse
    /// smaller than one of the solids it fused or larger than all of them together, a cut larger
    /// than the shape it was cut from or smaller than that less the tool, or a common larger than
    /// either side. OpenCASCADE returns such results without an error or a warning where faces
    /// graze or nearly coincide (a lofted thread ridge running out past the end of its core lost
    /// the core's volume to it; a duct cut from its inside kept 6 mm³ of its 1200 mm³ walls).
    ///
    /// The result's volume, and the bounds it is held to, are measured exactly (see
    /// [`volume`](Self::volume)). Integrating the solids directly, which is fast but can be off by
    /// percent on long lofts, only picks which to measure: a fuse is held below by the solid that
    /// looks largest (any solid's exact volume bounds it), a common above by the side that looks
    /// smaller.
    fn volume_problem(&self, other: &Shape, name: &str, result: &Raw) -> Result<Option<String>> {
        let (a, b) = (self.solids(), other.solids());
        if a.is_empty() || b.is_empty() || name == "section" {
            return Ok(None);
        }
        let rough = |solids: &Selection| -> Result<Vec<f64>> {
            solids.iter().map(|s| Ok(s.volume_props()?.Mass().abs())).collect()
        };
        let (rough_a, rough_b) = (rough(&a)?, rough(&b)?);
        let exact = |solids: &Selection| -> Result<f64> { solids.iter().map(Shape::volume).sum() };
        let (sum_a, sum_b) = (rough_a.iter().sum::<f64>(), rough_b.iter().sum::<f64>());
        // What a correct result's volume lies between, and the scale its slack is a part of.
        let (lower, upper, bound) = match name {
            "fuse" => {
                let solids = a.iter().zip(&rough_a).chain(b.iter().zip(&rough_b));
                let largest = match solids.max_by(|x, y| x.1.total_cmp(y.1)) {
                    Some((largest, _)) => largest.volume()?,
                    None => return Ok(None),
                };
                (largest, exact(&a)? + exact(&b)?, largest)
            },
            "cut" => {
                let from = exact(&a)?;
                // A cut removes no more than the tool's volume. Solids of a compound cut from may
                // overlap, so that bound only holds for one.
                let lower = if a.len() == 1 { from - exact(&b)? } else { f64::NEG_INFINITY };
                (lower, from, from)
            },
            _ if sum_a <= sum_b => {
                let side = exact(&a)?;
                (0.0, side, side)
            },
            _ => {
                let side = exact(&b)?;
                (0.0, side, side)
            },
        };
        // As the boolean returns it, and after the bounds, so that measuring the shape again
        // finds its split the newest kept.
        let result = Self::from_algorithm(result)?;
        let got = result.volume()?;
        if let Some(problem) = impossible_volume(name, got, lower, upper) {
            return Ok(Some(problem));
        }
        // OpenCASCADE can also miss that two solids meet at all, and then fuse them into a
        // compound of the two overlapping solids, cut nothing, or find nothing in common. Where a
        // result looks like that, a point on an edge of either shape strictly inside the other
        // proves they did overlap.
        // A cut that missed can still split faces along where the shapes meet, which moves the
        // integrated volume by a few parts in 1e8 (a helical groove cut from a cylinder), so
        // "removed nothing" means less than a millionth of the smaller side.
        let untouched = match name {
            "fuse" => result.solids().len() == a.len() + b.len(),
            // The bound is the exact volume of the shape cut from.
            "cut" => (got - bound).abs() <= 1e-6 * bound.min(sum_b),
            _ => result.solids().is_empty(),
        };
        // A cut can also go the other way and remove everything, although part of the shape lies
        // outside the tool: a point on its edges strictly outside the tool proves that.
        if name == "cut" && result.solids().is_empty() && self.reaches_outside(other)? {
            return Ok(Some(
                "the cut removed everything, although part of the shape lies outside what it was \
                 cut by: OpenCASCADE's boolean went wrong, which happens where faces graze or \
                 nearly coincide. Make the tool clearly smaller or clearly larger than the shape \
                 where their faces meet"
                    .into(),
            ));
        }
        if untouched && (self.reaches_into(other)? || other.reaches_into(self)?) {
            let missed = match name {
                "fuse" => "left them as separate, overlapping solids",
                "cut" => "removed nothing",
                _ => "found nothing in common",
            };
            return Ok(Some(format!(
                "the {name} {missed}, although the shapes overlap (an edge of one passes inside the \
                 other): OpenCASCADE's boolean missed where they meet, which happens where faces \
                 graze or nearly coincide. Make the shapes overlap clearly, and make tools run \
                 past the ends of what they join or cut rather than ending inside or flush with it"
            )));
        }
        Ok(None)
    }

    /// Whether a point of this shape's edges lies strictly outside all of `other`'s solids, which
    /// means some of this shape lies outside `other` (see [`Shape::reaches_into`]).
    fn reaches_outside(&self, other: &Shape) -> Result<bool> {
        for p in self.edge_samples()? {
            if other.classify(p)? == PointLocation::Outside {
                return Ok(true);
            }
        }
        Ok(false)
    }

    /// Points on this shape's edges: its vertices, and points along each edge.
    fn edge_samples(&self) -> Result<Vec<DVec3>> {
        let mut points: Vec<DVec3> =
            self.vertices().iter().map(|v| v.point()).collect::<Result<_>>()?;
        for edge in self.edges().iter() {
            // Degenerate edges (at the poles of a sphere) have no curve to sample.
            points.extend((1..8).filter_map(|k| edge.point_at(k as f64 / 8.0).ok()));
        }
        Ok(points)
    }

    /// Whether a point of this shape's edges (its vertices, and points along each edge) lies
    /// strictly inside one of `other`'s solids, which means the two overlap: near a point of its
    /// boundary, a shape has points of its own inside the other too. Each point is only tried
    /// against the solids whose bounding boxes hold it.
    fn reaches_into(&self, other: &Shape) -> Result<bool> {
        let mut targets = vec![];
        for solid in other.solids().iter() {
            targets.push((solid.clone(), solid.bounding_box()?));
        }
        for p in self.edge_samples()? {
            for (solid, bounds) in &targets {
                if bounds.contains(p) && solid.classify(p)? == PointLocation::Inside {
                    return Ok(true);
                }
            }
        }
        Ok(false)
    }

    /// The union of both shapes.
    pub fn fuse(&self, other: &Shape) -> Result<Self> {
        let result = self.boolean(other, "fuse", ffi::b_rep_algo_api::BRepAlgoAPI_fuse)?;
        Self::from_algorithm(&result)
    }

    /// This shape with `other` removed.
    pub fn cut(&self, other: &Shape) -> Result<Self> {
        let result = self.boolean(other, "cut", ffi::b_rep_algo_api::BRepAlgoAPI_cut)?;
        Self::from_algorithm(&result)
    }

    /// The intersection of both shapes.
    pub fn common(&self, other: &Shape) -> Result<Self> {
        let result = self.boolean(other, "common", ffi::b_rep_algo_api::BRepAlgoAPI_common)?;
        Self::from_algorithm(&result)
    }

    /// The edges where both shapes' boundaries intersect.
    pub fn section(&self, other: &Shape) -> Result<Self> {
        let result = self.boolean(other, "section", ffi::b_rep_algo_api::BRepAlgoAPI_section)?;
        Self::from_raw(&result)
    }

    /// The union of all shapes, in one operation: much faster than fusing them one at a time,
    /// which intersects the growing result with each shape in turn.
    pub fn fuse_all(shapes: &[Shape]) -> Result<Self> {
        let (first, rest) =
            shapes.split_first().ok_or_else(|| invalid("fuse_all needs at least one shape"))?;
        if rest.is_empty() {
            return Ok(first.clone());
        }
        let tools = Self::compound(rest)?;
        let result =
            first.boolean(&tools, "fuse", ffi::b_rep_algo_api::BRepAlgoAPI_fuse_children)?;
        Self::from_algorithm(&result)
    }

    // ---------------------------------------------------------------------------------------
    // Transforms
    // ---------------------------------------------------------------------------------------

    /// A copy of this shape moved by `transform`. A `rigid` one (a translation or a rotation) is
    /// remembered with this shape, so that measuring it reuses this shape's split.
    fn transformed(&self, transform: &ffi::gp::gp_Trsf, rigid: bool) -> Result<Self> {
        let mut make =
            ffi::b_rep_builder_api::BRepBuilderAPI_Transform_new(self.raw(), transform, true)?;
        let copy = Self::from_raw(make.pin_mut().Shape()?)?;
        if rigid {
            let by = Rc::new(ffi::top_loc::Location_from_transform(transform));
            COPIES.with_borrow_mut(|copies| {
                if copies.len() == KEPT_COPIES {
                    copies.remove(0);
                }
                copies.push((copy.clone(), self.clone(), by));
            });
        }
        Ok(copy)
    }

    pub fn translate(&self, delta: DVec3) -> Result<Self> {
        if !delta.is_finite() {
            return Err(invalid(format!("translation must be finite, got {}", fmt_vec(delta))));
        }
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().set_translation_vec(&vector(delta));
        self.transformed(&transform, true)
    }

    /// Rotates around the axis through `origin` along `axis` by `degrees` (right-hand rule).
    pub fn rotate(&self, origin: DVec3, axis: DVec3, degrees: f64) -> Result<Self> {
        require_finite(degrees, "rotation angle")?;
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().SetRotation(&*axis1(origin, axis)?, degrees.to_radians());
        self.transformed(&transform, true)
    }

    /// Scales uniformly about `center`. The factor must be non-zero (negative factors mirror).
    pub fn scale(&self, center: DVec3, factor: f64) -> Result<Self> {
        require_finite(factor, "scale factor")?;
        if factor.abs() < EPSILON {
            return Err(invalid("scale factor must not be zero"));
        }
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().SetScale(&point(center), factor);
        self.transformed(&transform, false)
    }

    /// Mirrors through the plane with the given origin and normal.
    pub fn mirror(&self, origin: DVec3, normal: DVec3) -> Result<Self> {
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().set_mirror_plane(&*axis2(origin, normal)?);
        self.transformed(&transform, false)
    }

    // ---------------------------------------------------------------------------------------
    // Feature operations
    // ---------------------------------------------------------------------------------------

    /// Closed wires become faces so that sweeping them produces solids.
    fn as_profile(&self) -> Result<Self> {
        if self.is(ShapeType::Wire) && self.is_closed() {
            Self::face_from(self)
        } else {
            Ok(self.clone())
        }
    }

    /// Sweeps the shape along `delta`: vertex → edge, edge → face, closed wire / face → solid.
    pub fn extrude(&self, delta: DVec3) -> Result<Self> {
        if !delta.is_finite() || delta.length() < EPSILON {
            return Err(invalid(format!(
                "extrusion vector must be non-zero, got {}",
                fmt_vec(delta)
            )));
        }
        let profile = self.as_profile()?;
        let mut make = ffi::b_rep_prim_api::BRepPrimAPI_MakePrism_new(
            profile.raw(),
            &vector(delta),
            true,
            true,
        )?;
        Self::from_algorithm(make.pin_mut().Shape()?)
    }

    /// Extrudes a planar face (or closed planar wire) `distance` along its normal.
    pub fn extrude_normal(&self, distance: f64) -> Result<Self> {
        require_finite(distance, "extrusion distance")?;
        let profile = self.as_profile()?;
        let normal = profile.normal()?;
        profile.extrude(normal * distance)
    }

    /// Revolves the shape around the axis through `origin` along `axis` by `degrees`.
    pub fn revolve(&self, origin: DVec3, axis: DVec3, degrees: f64) -> Result<Self> {
        require_finite(degrees, "revolution angle")?;
        if degrees.abs() < EPSILON || degrees.abs() > 360.0 {
            return Err(invalid(format!("revolution angle must be in (0, 360], got {degrees}")));
        }
        let profile = self.as_profile()?;
        let mut make = ffi::b_rep_prim_api::BRepPrimAPI_MakeRevol_new(
            profile.raw(),
            &*axis1(origin, axis)?,
            degrees.to_radians(),
            true,
        )?;
        Self::from_algorithm(make.pin_mut().Shape()?)
    }

    /// Sweeps the profile (this shape) along a path edge or wire.
    pub fn sweep(&self, path: &Shape) -> Result<Self> {
        // OpenCASCADE cannot interrupt a sweep, so do not start one that was cancelled.
        crate::cancel::check()?;
        let spine = match path.shape_type() {
            ShapeType::Wire => path.clone(),
            ShapeType::Edge => Self::wire_from(std::slice::from_ref(path))?,
            other => {
                return Err(Error::WrongShapeType {
                    expected: "edge or wire",
                    actual: other.name(),
                })
            },
        };
        let profile = self.as_profile()?;
        match profile.shape_type() {
            ShapeType::Face => {
                // The outer boundary sweeps into a solid, and so does each hole, which is then
                // cut out of it.
                let outer = profile.outer_wire()?;
                let solid = Self::pipe(&spine, &outer, true)?;
                let holes = profile
                    .wires()
                    .iter()
                    .filter(|w| !w.is_same(&outer))
                    .map(|hole| Self::pipe(&spine, &Self::face_from(hole)?.outer_wire()?, true))
                    .collect::<Result<Vec<_>>>()?;
                if holes.is_empty() {
                    Ok(solid)
                } else {
                    solid.cut(&Self::compound(&holes)?)
                }
            },
            ShapeType::Edge => Self::pipe(&spine, &Self::wire_from(&[profile])?, false),
            ShapeType::Wire => Self::pipe(&spine, &profile, false),
            _ => {
                let mut make = ffi::b_rep_offset_api::BRepOffsetAPI_MakePipe_new(
                    spine.wire()?,
                    profile.raw(),
                )?;
                if !make.IsDone() {
                    return Err(Error::OperationFailed("sweep"));
                }
                let swept = Self::from_algorithm(make.pin_mut().Shape()?)?;
                if !swept.is_valid() {
                    return Err(invalid(
                        "sweep failed: the swept shape is invalid, which OpenCASCADE's checker \
                         rejects",
                    ));
                }
                Ok(swept)
            },
        }
    }

    /// Sweeps the wire `profile` along `spine`, into a solid if `solid`, with OpenCASCADE's pipe
    /// shell. The profile keeps square to the path by the corrected Frenet frame, which also
    /// follows straight runs, and sharp corners in the path are mitred. Where that fails, or
    /// gives an invalid shape, the sweep fails: no other method is tried, as each would turn
    /// the profile along the path differently.
    fn pipe(spine: &Shape, profile: &Shape, solid: bool) -> Result<Self> {
        let mut make = ffi::b_rep_offset_api::BRepOffsetAPI_MakePipeShell_new(spine.wire()?)?;
        make.pin_mut().SetMode(false);
        ffi::b_rep_offset_api::BRepOffsetAPI_MakePipeShell_SetRightCorners(make.pin_mut());
        make.pin_mut().Add(profile.raw(), false, false)?;
        let built = make.pin_mut().Build(&progress()).is_ok()
            && make.IsDone()
            && (!solid || make.pin_mut().MakeSolid().unwrap_or(false));
        if !built {
            crate::cancel::check()?;
            return Err(invalid(
                "sweep failed: OpenCASCADE could not move the profile along this path while \
                 keeping it square to the path. Start the profile on the path's first point, \
                 square to it, and keep it smaller than the path's tightest bend. It also fails \
                 along some long helices whose pitch changes: use a constant pitch, or fewer turns",
            ));
        }
        let swept = Self::from_algorithm(make.pin_mut().Shape()?)?;
        if !swept.is_valid() {
            return Err(invalid(
                "sweep failed: the swept shape is invalid, which OpenCASCADE's checker rejects. \
                 That happens where the profile is wider than a bend in the path, where the path \
                 crosses itself, or where the profile isn't square to the path at its start. \
                 Sweep along a smooth path, wire([spline(points)]), that doesn't cross itself, \
                 with the profile on its first point and square to it: circle(points[0], \
                 path.edges()[0].tangent_at(0), r)",
            ));
        }
        Ok(swept)
    }

    /// A smooth shape passing through all sections (wires, or faces whose outer wire is used)
    /// exactly, curvature-continuous across each, that stays between each pair of sections
    /// however they are spaced: through circles of radius 12, 13, 16 and 11 at x = 0, 90, 172
    /// and 180, its radius stays between 12 and 13, 13 and 16, then 16 and 11. Sections with
    /// several edges, such as rounded rectangles, have their vertices matched up first, and the
    /// faces either side of an edge where a section is smooth stay tangent. Each section must
    /// span a plane, which says how the loft turns there: loft straight ones with
    /// [`ruled_loft`](Self::ruled_loft).
    pub fn loft(sections: &[Shape], solid: bool) -> Result<Self> {
        Self::loft_through(sections, solid, false)
    }

    /// A shape joining each section to the next with straight lines, so it stays between its
    /// sections, with a crease at each.
    pub fn ruled_loft(sections: &[Shape], solid: bool) -> Result<Self> {
        Self::loft_through(sections, solid, true)
    }

    fn loft_through(sections: &[Shape], solid: bool, ruled: bool) -> Result<Self> {
        if sections.len() < 2 {
            return Err(invalid("a loft needs at least 2 sections"));
        }
        // OpenCASCADE 7.8 ignores the progress range of lofts, fillets and chamfers, so they
        // cannot be interrupted once started; at least do not start them after a cancel.
        crate::cancel::check()?;
        let wires = sections
            .iter()
            .map(|section| match section.shape_type() {
                ShapeType::Face => section.outer_wire(),
                ShapeType::Edge => Self::wire_from(std::slice::from_ref(section)),
                _ => Ok(section.clone()),
            })
            .collect::<Result<Vec<_>>>()?;
        // OpenCASCADE matches up the sections' vertices first, so that sections with different
        // numbers of edges loft and the loft doesn't twist. Sections that are each one closed
        // edge, such as circles, have no vertices to match but their start points, so they are
        // joined start to start: matching them changes nothing where it works, and it fails on
        // circles around more than a few turns of a helix. (circle() starts circles along a path
        // on the same side; see `circle_edge`.)
        for wire in &wires {
            wire.wire()?;
        }
        let single = wires.iter().all(|w| w.is_closed() && w.edges().len() == 1);
        let closed = wires.iter().filter(|w| w.is_closed()).count();
        if closed != 0 && closed != wires.len() {
            return Err(invalid(
                "loft failed: every section must be a closed wire, or every one an open wire",
            ));
        }
        if solid && closed == 0 {
            return Err(invalid(
                "loft failed: a solid loft needs closed sections; loft open wires into a shell, \
                 with solid false",
            ));
        }
        let lofted = if ruled {
            let mut make = ffi::b_rep_offset_api::BRepOffsetAPI_ThruSections_new_ruled(solid, true);
            make.pin_mut().CheckCompatibility(!single);
            for wire in &wires {
                make.pin_mut().AddWire(wire.wire()?)?;
            }
            if make.pin_mut().Build(&progress()).is_err() || !make.IsDone() {
                crate::cancel::check()?;
                return Err(invalid(
                    "loft failed: OpenCASCADE could not join these sections. Make every section a \
                     closed wire (or every one open), with none crossing another; circles along a \
                     path are best made with circle(center, normal, r), which starts each on the \
                     same side",
                ));
            }
            Self::from_algorithm(make.pin_mut().Shape()?)?
        } else {
            crate::loft::loft(&wires, solid, !single)?
        };
        if !lofted.is_valid() {
            return Err(invalid(
                "loft failed: the lofted shape is invalid, which OpenCASCADE's checker rejects. \
                 That happens where sections cross one another or the loft twists between them: \
                 space the sections further apart, and make them run the same way round",
            ));
        }
        Ok(lofted)
    }

    fn require_edges(&self, edges: &[Shape], what: &str) -> Result<()> {
        if edges.is_empty() {
            return Err(Error::EmptySelection(format!("{what} needs at least one edge")));
        }
        for edge in edges {
            edge.expect(ShapeType::Edge)?;
        }
        Ok(())
    }

    /// Rounds the given edges of a solid.
    pub fn fillet(&self, radius: f64, edges: &[Shape]) -> Result<Self> {
        require_positive(radius, "fillet radius")?;
        self.require_edges(edges, "fillet")?;
        self.blend(Blend::Fillet, radius, edges, |shape, edges| {
            crate::cancel::check()?;
            let mut make = ffi::b_rep_fillet_api::BRepFilletAPI_MakeFillet_new(shape.raw())?;
            for edge in edges {
                make.pin_mut().add_edge(radius, edge.edge()?)?;
            }
            make.pin_mut().Build(&progress()).map_err(|e| occt_error("fillet", e))?;
            if !make.IsDone() {
                return Err(failed("fillet"));
            }
            Self::from_algorithm(make.pin_mut().Shape()?)
        })
    }

    /// Runs a fillet or chamfer of the selected edges that are corners, once.
    ///
    /// Selected edges that are no corner are left out, as there is nothing there to round and
    /// OpenCASCADE fails the whole operation on one: a seam, where a closed surface such as a
    /// cylinder meets itself (the seam of a horizontal cylinder can be its highest edge), and an
    /// edge between faces that continue each other. Selectors like `">Z"` pick both up.
    ///
    /// Among the second kind are the edges a boolean leaves where it fuses faces that continue
    /// each other, such as a boss's top flush with a plate's. OpenCASCADE can't round the edges
    /// that meet those either, and [`clean`](Self::clean) merges the faces; but it renumbers the
    /// shape's edges and faces, so the fillet does not clean on its own: it fails, saying to.
    fn blend(
        &self,
        kind: Blend,
        size: f64,
        edges: &[Shape],
        build: impl Fn(&Shape, &[Shape]) -> Result<Shape>,
    ) -> Result<Self> {
        let faces: Vec<(Shape, Selection)> =
            self.faces().iter().map(|face| (face.clone(), face.edges())).collect();
        let mut corners = Vec::with_capacity(edges.len());
        for edge in edges {
            if Self::is_corner(edge, &faces)? {
                corners.push(edge.clone());
            }
        }
        if corners.is_empty() {
            let (what, verb) = kind.words();
            return Err(Error::EmptySelection(format!(
                "{what} needs at least one edge where two faces meet at a corner, but the \
                 selected edges are all seams, where a closed surface such as a cylinder meets \
                 itself, or edges between faces that continue each other: there is no corner \
                 there to {verb}. Select the edges between faces that meet at an angle instead"
            )));
        }
        let edges = &corners[..];
        // OpenCASCADE can also report success and return a broken solid, for instance for a
        // chamfer wider than a rounded corner beside it; booleans, meshes and exports of it then
        // fail, or come out empty, far from the line that broke it.
        let error = match build(self, edges) {
            Ok(blended) if blended.is_valid() => return Ok(blended),
            Ok(_) => blend_invalid(kind, size, edges.len(), self.is_valid()),
            Err(Error::Cancelled) => return Err(Error::Cancelled),
            Err(_) => blend_failed(kind, size, edges.len()),
        };
        // Faces that clean() would merge are faces a boolean split.
        if self.clean()?.faces().len() < self.faces().len() {
            return Err(invalid(format!("{}. {}", error, blend_split(kind, size))));
        }
        Err(invalid(error))
    }

    /// Whether `edge` is a corner between the faces it bounds, given each face with its edges:
    /// not a seam, and between faces that don't continue each other.
    fn is_corner(edge: &Shape, faces: &[(Shape, Selection)]) -> Result<bool> {
        let mut sides = Vec::with_capacity(2);
        for (face, face_edges) in faces {
            if ffi::b_rep::BRep_Tool_IsClosed_on_face(edge.edge()?, face.face()?) {
                return Ok(false);
            }
            if face_edges.iter().any(|e| e.is_same(edge)) {
                sides.push(face);
            }
        }
        match sides[..] {
            [a, b] => Ok(!Self::continue_each_other(a, b, edge)?),
            _ => Ok(true),
        }
    }

    /// Whether the faces `a` and `b` on either side of `edge` continue each other across it,
    /// with no corner: their outward normals agree along it (at a quarter, half and three
    /// quarters of its length) to within a ten-thousandth of a degree.
    fn continue_each_other(a: &Shape, b: &Shape, edge: &Shape) -> Result<bool> {
        for t in [0.25, 0.5, 0.75] {
            let p = edge.point_at(t)?;
            if a.normal_near(p)?.dot(b.normal_near(p)?) < (1e-4f64).to_radians().cos() {
                return Ok(false);
            }
        }
        Ok(true)
    }

    /// Rounds every edge.
    pub fn fillet_all(&self, radius: f64) -> Result<Self> {
        self.fillet(radius, self.edges().shapes())
    }

    /// Bevels the given edges of a solid with equal distances.
    pub fn chamfer(&self, distance: f64, edges: &[Shape]) -> Result<Self> {
        require_positive(distance, "chamfer distance")?;
        self.require_edges(edges, "chamfer")?;
        self.blend(Blend::Chamfer, distance, edges, |shape, edges| {
            crate::cancel::check()?;
            let mut make = ffi::b_rep_fillet_api::BRepFilletAPI_MakeChamfer_new(shape.raw())?;
            for edge in edges {
                make.pin_mut().add_edge(distance, edge.edge()?)?;
            }
            make.pin_mut().Build(&progress()).map_err(|e| occt_error("chamfer", e))?;
            if !make.IsDone() {
                return Err(failed("chamfer"));
            }
            Self::from_algorithm(make.pin_mut().Shape()?)
        })
    }

    /// Bevels every edge.
    pub fn chamfer_all(&self, distance: f64) -> Result<Self> {
        self.chamfer(distance, self.edges().shapes())
    }

    /// Hollows a solid, giving the walls `thickness`: a negative thickness grows the walls
    /// inwards, a positive one outwards. The `open_faces` are removed, leaving openings; with no
    /// open faces the result is a closed solid with an internal void.
    pub fn shell(&self, thickness: f64, open_faces: &[Shape]) -> Result<Self> {
        require_finite(thickness, "shell thickness")?;
        if thickness.abs() < EPSILON {
            return Err(invalid("shell thickness must not be zero"));
        }
        for face in open_faces {
            face.expect(ShapeType::Face)?;
        }
        let thick = self.thick_solid(thickness, open_faces)?;
        if !open_faces.is_empty() {
            return Ok(thick);
        }
        // Without open faces OCCT returns the offset solid itself; subtract to get the walls.
        let walls = if thickness < 0.0 { self.cut(&thick) } else { thick.cut(self) };
        walls.map_err(|e| match e {
            Error::Cancelled => e,
            e => invalid(format!("shell failed: subtracting the offset solid failed: {e}")),
        })
    }

    /// OpenCASCADE's thick solid (with `open_faces`) or offset solid (without), with CadQuery's
    /// settings: offset faces are intersected with all the others, not only their neighbours,
    /// and outward corners are rounded. OpenCASCADE's defaults fail on rounded enclosures that
    /// these shell. It can report success and still return an invalid solid, or the input
    /// unchanged, notably where the wall is at least as thick as a fillet it offsets inward:
    /// either is an error.
    fn thick_solid(&self, thickness: f64, open_faces: &[Shape]) -> Result<Self> {
        let mut faces = ffi::top_tools::new_list_of_shape();
        for face in open_faces {
            faces.pin_mut().Append(face.raw());
        }
        let mut make = ffi::b_rep_offset_api::BRepOffsetAPI_MakeThickSolid_new();
        let built = make.pin_mut().MakeThickSolidByJoin(
            self.raw(),
            &faces,
            thickness,
            1e-3,
            ffi::b_rep_offset_api::BRepOffset_Mode::BRepOffset_Skin,
            true,
            false,
            ffi::geom_abs::GeomAbs_JoinType::GeomAbs_Arc,
            false,
            &progress(),
        );
        crate::cancel::check()?;
        if built.is_err() || !make.IsDone() {
            return Err(shell_failed(self, thickness));
        }
        let thick = Self::from_algorithm(make.pin_mut().Shape()?)?;
        // Integrating directly, rather than exactly, is enough to tell the input returned
        // unchanged: the same geometry integrates to the same number. (Offsetting free-form faces
        // makes offset surfaces, which can't be measured exactly; see `for_measuring`.)
        let (before, after) = (self.volume_props()?.Mass(), thick.volume_props()?.Mass());
        if !thick.is_valid() || (after.abs() - before.abs()).abs() <= 1e-6 * before.abs() {
            return Err(shell_failed(self, thickness));
        }
        Ok(thick)
    }

    /// Offsets a planar wire or face within its plane (positive grows it). A face keeps its
    /// holes; an offset that splits the shape into separate regions is an error. An open wire
    /// or an edge grows into the closed outline around it: a slot around a line.
    pub fn offset_2d(&self, distance: f64) -> Result<Self> {
        require_finite(distance, "offset distance")?;
        match self.shape_type() {
            ShapeType::Face => {},
            ShapeType::Wire if self.is_closed() => {
                // Offsetting the face keeps the orientation consistent: positive grows outwards.
                let face = Self::face_from(self)?;
                let offset = face.offset_2d(distance)?;
                return offset.wires().first();
            },
            ShapeType::Wire => return self.outline(distance),
            ShapeType::Edge => {
                return Self::wire_from(std::slice::from_ref(self))?.offset_2d(distance)
            },
            other => {
                return Err(Error::WrongShapeType {
                    expected: "wire, edge or face",
                    actual: other.name(),
                })
            },
        }
        // OpenCASCADE offsets B-spline edges into an invalid outline where they bend more tightly
        // than the offset, with no error: that is an error here.
        let crossing = || {
            invalid(format!(
                "offset failed: an offset of {distance} of this outline comes out crossing itself, \
                 which happens where the outline bends more tightly than the offset (inward bends \
                 for a positive offset, outward ones for a negative). Offset by less, or make \
                 those bends wider"
            ))
        };
        let join = ffi::geom_abs::GeomAbs_JoinType::GeomAbs_Arc;
        let mut make =
            ffi::b_rep_offset_api::BRepOffsetAPI_MakeOffset_face_new(self.face()?, join)?;
        if make.pin_mut().Perform(distance, 0.0).is_err() || !make.IsDone() {
            return Err(crossing());
        }
        // One wire per boundary of the result: the largest bounds the face and the others are
        // its holes, unless the offset split the face, which leaves wires outside the largest.
        let mut wires = Self::from_raw(make.pin_mut().Shape()?)?
            .wires()
            .iter()
            .map(|wire| Ok((Self::face_from(wire)?.area()?, wire.clone())))
            .collect::<Result<Vec<_>>>()?;
        wires.sort_by(|a, b| b.0.total_cmp(&a.0));
        let Some(((outer_area, outer), holes)) = wires.split_first() else {
            return Err(crossing());
        };
        let hole_area: f64 = holes.iter().map(|(area, _)| area).sum();
        let holes: Vec<Self> = holes.iter().map(|(_, wire)| wire.clone()).collect();
        let split = || {
            invalid(format!(
                "an offset of {distance} splits the shape into separate regions; shrink it by less"
            ))
        };
        let face = Self::face_with_holes(outer, &holes).map_err(|e| match e {
            Error::Cancelled => e,
            _ => split(),
        })?;
        if (face.area()? - (outer_area - hole_area)).abs() > 1e-6 * outer_area {
            return Err(split());
        }
        if !face.is_valid()
            || !face.lies_at(distance.abs(), &Self::compound(self.wires().shapes())?)?
        {
            return Err(crossing());
        }
        Ok(face)
    }

    /// Whether every edge of this shape lies `distance` from `other`, as an offset of it does: at
    /// nine points along each, to within a millionth of the distance. An offset that crosses
    /// itself, or meets the offset of another of the outline's boundaries, comes nearer.
    fn lies_at(&self, distance: f64, other: &Shape) -> Result<bool> {
        for edge in self.edges().iter() {
            for k in 0..=8 {
                let p = Self::vertex_at(edge.point_at(k as f64 / 8.0)?)?;
                if (p.distance(other)? - distance).abs() > 1e-6 * distance.max(1.0) {
                    return Ok(false);
                }
            }
        }
        Ok(true)
    }

    /// The closed outline `distance` around an open wire: a slot around a line, or a bent slot
    /// around a polyline or an arc.
    fn outline(&self, distance: f64) -> Result<Self> {
        if distance <= 0.0 {
            return Err(invalid(format!(
                "an open wire can only grow into the outline around it, so its offset must be \
                 positive, got {distance}. To shrink an outline, close it first: polygon(points) \
                 rather than polyline(points), or end a sketch with close()"
            )));
        }
        // A straight line lies in many planes, so OpenCASCADE can't offset it: its slot is made
        // here, in the horizontal plane, running counter-clockwise seen from above.
        if let [line] = self.edges().shapes() {
            if line.geom_type()? == "line" {
                return Self::slot(line, distance);
            }
        }
        let failed = || {
            invalid(format!(
                "offset failed: OpenCASCADE could not offset this open wire by {distance}. It \
                 must lie in one plane (a straight wire of several edges lies in many: draw its \
                 slot as a sketch on the plane you want), and not bend more tightly than the \
                 offset"
            ))
        };
        let join = ffi::geom_abs::GeomAbs_JoinType::GeomAbs_Arc;
        let mut make =
            ffi::b_rep_offset_api::BRepOffsetAPI_MakeOffset_wire_new(self.wire()?, join)?;
        if make.pin_mut().Perform(distance, 0.0).is_err() || !make.IsDone() {
            return Err(failed());
        }
        let wires = Self::from_raw(make.pin_mut().Shape()?)?.wires();
        match wires.shapes() {
            [outline]
                if outline.is_closed()
                    && Self::face_from(outline)?.is_valid()
                    && outline.lies_at(distance, self)? =>
            {
                Ok(outline.clone())
            },
            _ => Err(failed()),
        }
    }

    /// The slot `distance` around a horizontal straight edge, in the horizontal plane.
    fn slot(line: &Shape, distance: f64) -> Result<Self> {
        let (start, end) = (line.start_point()?, line.end_point()?);
        let along = end - start;
        if along.z.abs() > EPSILON * along.length().max(1.0) {
            return Err(invalid(
                "offset failed: a straight line that isn't horizontal lies in many planes, so \
                 the slot around it could lie in any of them: draw its slot as a sketch on the \
                 plane you want instead",
            ));
        }
        let ahead = along.normalize() * distance;
        let left = DVec3::Z.cross(ahead);
        Self::wire_from(&[
            Self::line(start - left, end - left)?,
            Self::arc(end - left, end + ahead, end + left)?,
            Self::line(end + left, start + left)?,
            Self::arc(start + left, start - ahead, start - left)?,
        ])
    }

    /// Merges coplanar faces and collinear edges left behind by boolean operations.
    pub fn clean(&self) -> Result<Self> {
        crate::cancel::check()?;
        let mut unify = ffi::shape_upgrade::UnifySameDomain_new(self.raw(), true, true, true)?;
        unify.pin_mut().build()?;
        Self::from_algorithm(unify.shape()?)
    }

    // ---------------------------------------------------------------------------------------
    // Exploration
    // ---------------------------------------------------------------------------------------

    /// The distinct sub-shapes of the given type, in exploration order.
    pub fn subshapes(&self, kind: ShapeType) -> Selection {
        let mut map = ffi::top_tools::new_indexed_map_of_shape();
        // MapShapes cannot fail for the non-null shapes `Shape` holds; were it to, the map would
        // simply stay empty.
        let _ = ffi::top_exp::TopExp::MapShapes(self.raw(), kind.to_ffi(), map.pin_mut());
        let shapes = (1..=map.Extent())
            .filter_map(|i| map.FindKey(i).ok().and_then(|s| Shape::from_raw(s).ok()))
            .collect();
        Selection::new(shapes)
    }

    pub fn vertices(&self) -> Selection {
        self.subshapes(ShapeType::Vertex)
    }

    pub fn edges(&self) -> Selection {
        self.subshapes(ShapeType::Edge)
    }

    pub fn wires(&self) -> Selection {
        self.subshapes(ShapeType::Wire)
    }

    pub fn faces(&self) -> Selection {
        self.subshapes(ShapeType::Face)
    }

    pub fn shells(&self) -> Selection {
        self.subshapes(ShapeType::Shell)
    }

    pub fn solids(&self) -> Selection {
        self.subshapes(ShapeType::Solid)
    }

    /// The direct children of a compound (or any other shape).
    pub fn children(&self) -> usize {
        self.inner.NbChildren() as usize
    }

    // ---------------------------------------------------------------------------------------
    // Measurements
    // ---------------------------------------------------------------------------------------

    fn props(
        &self,
        compute: impl FnOnce(
            &ffi::topo_ds::TopoDS_Shape,
            std::pin::Pin<&mut ffi::g_prop::GProp_GProps>,
        ) -> std::result::Result<(), cxx::Exception>,
    ) -> Result<UniquePtr<ffi::g_prop::GProp_GProps>> {
        let mut props = ffi::g_prop::GProps_new();
        compute(self.raw(), props.pin_mut())?;
        Ok(props)
    }

    fn volume_props(&self) -> Result<UniquePtr<ffi::g_prop::GProp_GProps>> {
        self.props(|s, p| ffi::b_rep_g_prop::BRepGProp::VolumeProperties(s, p, false, false, false))
    }

    fn surface_props(&self) -> Result<UniquePtr<ffi::g_prop::GProp_GProps>> {
        // Shared faces/edges count once.
        self.props(|s, p| ffi::b_rep_g_prop::BRepGProp::SurfaceProperties(s, p, true, false))
    }

    fn linear_props(&self) -> Result<UniquePtr<ffi::g_prop::GProp_GProps>> {
        self.props(|s, p| ffi::b_rep_g_prop::BRepGProp::LinearProperties(s, p, true, false))
    }

    /// The shape to measure exactly: itself when all its geometry is analytic (lines, conics,
    /// planes, cylinders, cones, spheres and tori), and otherwise a copy split into Bézier pieces,
    /// one per span of every B-spline curve and surface. OpenCASCADE integrates each face at a
    /// fixed number of Gauss points: exact for analytic faces, but off by percent on lofts, sweeps
    /// and extruded splines, whose faces have many spans. On a single Bézier patch the same
    /// integration is accurate, to about 1e-7. (Its adaptive integrations report a tiny error on
    /// such faces while getting them wrong, and can take minutes.) Closed faces, such as a torus,
    /// are cut open first: splitting the edges of a face that wraps around corrupts its boundary.
    ///
    /// Fails, rather than measure approximately, when the split fails, or leaves a face whose
    /// surface isn't smooth throughout.
    fn for_measuring(&self) -> Result<Self> {
        let free_form = |s: &Shape| {
            // Degenerate edges, at the poles of a sphere, have no curve and need nothing.
            matches!(
                s.geom_type(),
                Ok("bezier" | "bspline" | "revolution" | "extrusion" | "offset" | "other")
            )
        };
        if !self.faces().iter().any(free_form) && !self.edges().iter().any(free_form) {
            return Ok(self.clone());
        }
        // A copy moved rigidly (translated or rotated) is its source's split, moved with it, so
        // copies of one shape (the blades of a blisk, a pattern of bosses) share one split.
        let copied = COPIES.with_borrow(|copies| {
            copies
                .iter()
                .find(|(copy, ..)| copy.is_same(self))
                .map(|(_, source, by)| (source.clone(), by.clone()))
        });
        if let Some((source, by)) = copied {
            let mut moved = ffi::topo_ds::TopoDS_Shape_to_owned(source.for_measuring()?.raw());
            moved.pin_mut().translate(&by, false)?;
            return Self::from_unique(moved);
        }
        // Splitting takes most of the time, and the same shape is often measured more than once,
        // as a boolean's result and then the script's: the last few splits are kept. A shape
        // never changes, so its split stays right.
        let cached = SPLITS.with_borrow(|splits| {
            splits.iter().find(|(shape, _)| shape.is_same(self)).map(|(_, split)| split.clone())
        });
        if let Some(split) = cached {
            return Ok(split);
        }
        let split = self.split_for_measuring()?;
        SPLITS.with_borrow_mut(|splits| {
            if splits.len() == KEPT_SPLITS {
                splits.remove(0);
            }
            splits.push((self.clone(), split.clone()));
        });
        Ok(split)
    }

    /// The Bézier split [`for_measuring`](Self::for_measuring) measures, checked.
    fn split_for_measuring(&self) -> Result<Self> {
        // The conversion works on a copy, so a failure leaves this shape as it was.
        let split =
            ffi::shape_upgrade::ShapeUpgrade_convert_to_bezier(self.raw()).map_err(|e| {
                invalid(format!(
                "the shape can't be measured exactly: OpenCASCADE could not split its B-spline \
                 faces into Bézier patches ({})",
                e.what()
            ))
            })?;
        let split = Self::from_unique(split)?;
        split.require_smooth_faces()?;
        Ok(split)
    }

    /// Fails unless every face's surface is smooth throughout. Integrating at fixed points is
    /// accurate on a face only where it is. The split for measuring cuts offset surfaces, which
    /// shelling free-form faces makes, at their base surface's knots, but can't turn them into
    /// Bézier patches.
    fn require_smooth_faces(&self) -> Result<()> {
        let mut rough = 0;
        for face in self.faces().iter() {
            let surface = ffi::b_rep_adaptor::BRepAdaptor_Surface_new(face.face()?, true)?;
            if ffi::b_rep_adaptor::BRepAdaptor_Surface_smooth_patches(&surface)? != 1 {
                rough += 1;
            }
        }
        if rough > 0 {
            return Err(invalid(format!(
                "the shape can't be measured exactly: {rough} of its faces could not be split into \
                 pieces that are smooth throughout"
            )));
        }
        Ok(())
    }

    /// The enclosed volume (0 for shapes without solids), measured exactly (see
    /// [`mass_properties`](Self::mass_properties)).
    pub fn volume(&self) -> Result<f64> {
        Ok(self.for_measuring()?.volume_props()?.Mass().abs())
    }

    /// The total area of all faces, measured exactly.
    pub fn area(&self) -> Result<f64> {
        Ok(self.for_measuring()?.surface_props()?.Mass())
    }

    /// The volume, area and center of mass together, which splits the shape for measuring
    /// once instead of three times. They are exact to about 1e-7, or an error: a shape whose
    /// faces can't all be split into Bézier patches can't be measured.
    pub fn mass_properties(&self) -> Result<MassProperties> {
        let measured = self.for_measuring()?;
        Ok(MassProperties {
            volume: measured.volume_props()?.Mass().abs(),
            area: measured.surface_props()?.Mass(),
            center: measured.center_of_mass()?,
        })
    }

    /// The total length of all edges.
    pub fn length(&self) -> Result<f64> {
        Ok(self.linear_props()?.Mass())
    }

    /// The center of mass, using the highest-dimensional content of the shape: volume for
    /// solids, area for faces and shells, length for edges and wires.
    pub fn center(&self) -> Result<DVec3> {
        self.for_measuring()?.center_of_mass()
    }

    fn center_of_mass(&self) -> Result<DVec3> {
        let props = match self.shape_type() {
            ShapeType::Vertex => return self.point(),
            ShapeType::Edge | ShapeType::Wire => self.linear_props()?,
            ShapeType::Face | ShapeType::Shell => self.surface_props()?,
            ShapeType::Solid | ShapeType::CompSolid => self.volume_props()?,
            ShapeType::Compound => {
                if !self.solids().is_empty() {
                    self.volume_props()?
                } else if !self.faces().is_empty() {
                    self.surface_props()?
                } else if !self.edges().is_empty() {
                    self.linear_props()?
                } else {
                    let vertices = self.vertices();
                    if vertices.is_empty() {
                        return Err(invalid("an empty shape has no center"));
                    }
                    let sum = vertices.iter().map(|v| v.point()).sum::<Result<DVec3>>()?;
                    return Ok(sum / vertices.len() as f64);
                }
            },
        };
        Ok(from_pnt(&ffi::g_prop::GProp_GProps_CentreOfMass(&props)))
    }

    /// The tight axis-aligned bounding box.
    ///
    /// OpenCASCADE bounds edges tightly, but a curved face over the whole rectangle of
    /// parameters its boundary spans, which can reach well past the face: a tube cut square by a
    /// boolean keeps the box of the uncut tube. So the box starts from the edges and vertices,
    /// and grows by a curved face only as far as the face really reaches, found as its distance
    /// to a plane just beyond it. Fails where that distance can't be found, rather than return
    /// a looser box.
    pub fn bounding_box(&self) -> Result<BoundingBox> {
        let loose = optimal_box(self.raw())?
            .ok_or_else(|| invalid("an empty shape has no bounding box"))?;
        let curved: Vec<Shape> =
            self.faces().iter().filter(|f| f.geom_type() != Ok("plane")).cloned().collect();
        if curved.is_empty() {
            return Ok(loose);
        }
        let mut outline: Vec<Shape> = self.edges().shapes().to_vec();
        outline.extend(self.vertices().iter().cloned());
        let mut tight = optimal_box(Self::compound(&outline)?.raw())?;
        let slack = 1e-9 + 1e-7 * loose.size().length();
        for face in &curved {
            let Some(reach) = optimal_box(face.raw())? else { continue };
            let bounds = tight.get_or_insert(reach);
            for axis in 0..3 {
                if reach.max[axis] > bounds.max[axis] + slack {
                    let extreme = face.extreme(axis, 1.0, &reach)?;
                    bounds.max[axis] = bounds.max[axis].max(extreme.min(reach.max[axis]));
                }
                if reach.min[axis] < bounds.min[axis] - slack {
                    let extreme = face.extreme(axis, -1.0, &reach)?;
                    bounds.min[axis] = bounds.min[axis].min(extreme.max(reach.min[axis]));
                }
            }
        }
        tight.ok_or_else(|| invalid("an empty shape has no bounding box"))
    }

    /// How far this shape reaches along `axis` (0, 1 or 2 for X, Y or Z) in the direction of
    /// `sign`, given a box that bounds it: its distance to a plane square to the axis just
    /// beyond the box.
    fn extreme(&self, axis: usize, sign: f64, bounds: &BoundingBox) -> Result<f64> {
        let margin = 1e-3 + 0.01 * bounds.size().length();
        let level = if sign > 0.0 { bounds.max[axis] } else { bounds.min[axis] } + sign * margin;
        let (u, w) = ((axis + 1) % 3, (axis + 2) % 3);
        let corner = |a: f64, b: f64| {
            let mut p = DVec3::ZERO;
            p[axis] = level;
            p[u] = if a > 0.0 { bounds.max[u] + margin } else { bounds.min[u] - margin };
            p[w] = if b > 0.0 { bounds.max[w] + margin } else { bounds.min[w] - margin };
            p
        };
        let plane = Self::face_from(&Self::polygon(&[
            corner(-1.0, -1.0),
            corner(1.0, -1.0),
            corner(1.0, 1.0),
            corner(-1.0, 1.0),
        ])?)?;
        Ok(level - sign * self.distance(&plane)?)
    }

    /// Whether OpenCASCADE's checker considers the shape topologically and geometrically valid.
    pub fn is_valid(&self) -> bool {
        valid(self.raw())
    }

    /// Whether an edge, wire or shell is closed. Solids are always closed.
    pub fn is_closed(&self) -> bool {
        match self.shape_type() {
            ShapeType::Solid | ShapeType::CompSolid => true,
            _ => ffi::b_rep::BRep_Tool::IsClosed(self.raw()),
        }
    }

    /// The minimum distance between the two shapes (0 when they touch or overlap).
    pub fn distance(&self, other: &Shape) -> Result<f64> {
        let dist = ffi::b_rep_extrema::BRepExtrema_DistShapeShape_new(self.raw(), other.raw())?;
        if !dist.IsDone() {
            return Err(Error::OperationFailed("distance computation"));
        }
        Ok(dist.Value()?)
    }

    /// The closest points on this shape and on `other`.
    pub fn closest_points(&self, other: &Shape) -> Result<(DVec3, DVec3)> {
        let dist = ffi::b_rep_extrema::BRepExtrema_DistShapeShape_new(self.raw(), other.raw())?;
        if !dist.IsDone() || dist.NbSolution() < 1 {
            return Err(Error::OperationFailed("distance computation"));
        }
        let a = ffi::b_rep_extrema::BRepExtrema_DistShapeShape_point_on_shape_1(&dist, 1)?;
        let b = ffi::b_rep_extrema::BRepExtrema_DistShapeShape_point_on_shape_2(&dist, 1)?;
        Ok((from_pnt(&a), from_pnt(&b)))
    }

    /// Whether `p` lies inside, outside or on the boundary of the shape's solids. A point
    /// inside any of the solids of a compound is inside.
    pub fn classify(&self, p: DVec3) -> Result<PointLocation> {
        if !p.is_finite() {
            return Err(invalid(format!("point must be finite, got {}", fmt_vec(p))));
        }
        let solids = self.solids();
        if solids.is_empty() {
            return Err(Error::WrongShapeType {
                expected: "solid (or a shape containing solids)",
                actual: self.shape_type().name(),
            });
        }
        let mut on_boundary = false;
        for solid in solids.iter() {
            use ffi::top_abs::TopAbs_State as State;
            match ffi::b_rep_class3d::classify_point(solid.raw(), &point(p), CLASSIFY_TOLERANCE)? {
                State::TopAbs_IN => return Ok(PointLocation::Inside),
                State::TopAbs_ON => on_boundary = true,
                State::TopAbs_OUT => {},
                _ => return Err(failed("point classification")),
            }
        }
        Ok(if on_boundary { PointLocation::OnBoundary } else { PointLocation::Outside })
    }

    /// Whether `p` lies inside the shape's solids or on their boundary.
    pub fn contains(&self, p: DVec3) -> Result<bool> {
        Ok(self.classify(p)? != PointLocation::Outside)
    }

    // ---------------------------------------------------------------------------------------
    // Vertex, edge and face queries
    // ---------------------------------------------------------------------------------------

    /// The position of a vertex.
    pub fn point(&self) -> Result<DVec3> {
        Ok(from_pnt(&*ffi::b_rep::BRep_Tool_Pnt(self.vertex()?)?))
    }

    fn curve(&self) -> Result<UniquePtr<ffi::b_rep_adaptor::BRepAdaptor_Curve>> {
        Ok(ffi::b_rep_adaptor::BRepAdaptor_Curve_new(self.edge()?)?)
    }

    fn parameter(curve: &ffi::b_rep_adaptor::BRepAdaptor_Curve, t: f64) -> Result<f64> {
        require_finite(t, "curve parameter")?;
        if !(0.0..=1.0).contains(&t) {
            return Err(invalid(format!("curve parameter must be within [0, 1], got {t}")));
        }
        let (first, last) = (curve.FirstParameter(), curve.LastParameter());
        Ok(first + (last - first) * t)
    }

    /// The point at normalized parameter `t` ∈ [0, 1] along an edge.
    pub fn point_at(&self, t: f64) -> Result<DVec3> {
        let curve = self.curve()?;
        let u = Self::parameter(&curve, t)?;
        Ok(from_pnt(&*ffi::b_rep_adaptor::BRepAdaptor_Curve_value(&curve, u)?))
    }

    /// The unit tangent at normalized parameter `t` ∈ [0, 1] along an edge.
    pub fn tangent_at(&self, t: f64) -> Result<DVec3> {
        let curve = self.curve()?;
        let u = Self::parameter(&curve, t)?;
        let mut p = point(DVec3::ZERO);
        let mut v = vector(DVec3::ZERO);
        curve.D1(u, p.pin_mut(), v.pin_mut())?;
        math::normalize(from_vec(&v))
    }

    pub fn start_point(&self) -> Result<DVec3> {
        self.point_at(0.0)
    }

    pub fn end_point(&self) -> Result<DVec3> {
        self.point_at(1.0)
    }

    /// The radius of a circular edge.
    pub fn radius(&self) -> Result<f64> {
        let curve = self.curve()?;
        let circle = ffi::b_rep_adaptor::BRepAdaptor_Curve_circle(&curve)
            .map_err(|_| invalid("only circular edges have a radius"))?;
        Ok(circle.Radius())
    }

    /// The geometry type of an edge (`"line"`, `"circle"`, `"ellipse"`, `"hyperbola"`,
    /// `"parabola"`, `"bezier"`, `"bspline"`, `"offset"`, `"other"`) or of a face (`"plane"`,
    /// `"cylinder"`, `"cone"`, `"sphere"`, `"torus"`, `"bezier"`, `"bspline"`, `"revolution"`,
    /// `"extrusion"`, `"offset"`, `"other"`).
    pub fn geom_type(&self) -> Result<&'static str> {
        match self.shape_type() {
            ShapeType::Edge => Ok(curve_type_name(self.curve()?.GetType())),
            ShapeType::Face => {
                let surface = ffi::b_rep_adaptor::BRepAdaptor_Surface_new(self.face()?, true)?;
                Ok(surface_type_name(surface.GetType()))
            },
            other => Err(Error::WrongShapeType { expected: "edge or face", actual: other.name() }),
        }
    }

    /// The direction of a straight edge, from its start to its end point.
    pub fn line_direction(&self) -> Result<DVec3> {
        if self.geom_type()? != "line" {
            return Err(invalid("only straight edges have a direction"));
        }
        math::normalize(self.end_point()? - self.start_point()?)
    }

    /// The outward unit normal of a face at its center, or the normal of the plane of a closed
    /// planar wire.
    pub fn normal(&self) -> Result<DVec3> {
        if self.is(ShapeType::Wire) {
            return Self::face_from(self)?.normal();
        }
        self.normal_near(self.center()?)
    }

    /// The outward unit normal of a face at the point of its surface nearest `p`.
    fn normal_near(&self, p: DVec3) -> Result<DVec3> {
        let face = self.face()?;
        let surface = ffi::b_rep::BRep_Tool_Surface(face)?;
        let projector = ffi::geom_api::GeomAPI_ProjectPointOnSurf_new(&point(p), &surface)?;
        let (mut u, mut v) = (0.0, 0.0);
        ffi::geom_api::GeomAPI_ProjectPointOnSurf_LowerDistanceParameters(
            &projector, &mut u, &mut v,
        )
        .map_err(|_| {
            invalid(format!(
                "cannot find the face's normal at {}: the point is as near to many points of its \
                 surface as to any one (it lies on the axis of a full cylinder, or at the center \
                 of a sphere, say), so there is no one normal there",
                fmt_vec(p)
            ))
        })?;
        let props = ffi::b_rep_g_prop::BRepGProp_Face_new(face)?;
        let mut p = point(DVec3::ZERO);
        let mut n = vector(DVec3::ZERO);
        props.Normal(u, v, p.pin_mut(), n.pin_mut())?;
        math::normalize(from_vec(&n))
    }

    /// A sketch plane lying on a planar face: centered on the face, with the face's normal.
    pub fn plane(&self) -> Result<Plane> {
        self.expect(ShapeType::Face)?;
        if self.geom_type()? != "plane" {
            return Err(invalid("only planar faces define a plane"));
        }
        Plane::new(self.center()?, self.normal()?)
    }

    /// The outer boundary of a face.
    pub fn outer_wire(&self) -> Result<Self> {
        let wire = ffi::b_rep_tools::outer_wire(self.face()?)?;
        Self::from_raw(ffi::topo_ds::cast_wire_to_shape(&wire))
    }
}

pub(crate) fn curve_type_name(kind: ffi::geom_abs::GeomAbs_CurveType) -> &'static str {
    use ffi::geom_abs::GeomAbs_CurveType as C;
    match kind {
        C::GeomAbs_Line => "line",
        C::GeomAbs_Circle => "circle",
        C::GeomAbs_Ellipse => "ellipse",
        C::GeomAbs_Hyperbola => "hyperbola",
        C::GeomAbs_Parabola => "parabola",
        C::GeomAbs_BezierCurve => "bezier",
        C::GeomAbs_BSplineCurve => "bspline",
        C::GeomAbs_OffsetCurve => "offset",
        _ => "other",
    }
}

pub(crate) fn surface_type_name(kind: ffi::geom_abs::GeomAbs_SurfaceType) -> &'static str {
    use ffi::geom_abs::GeomAbs_SurfaceType as S;
    match kind {
        S::GeomAbs_Plane => "plane",
        S::GeomAbs_Cylinder => "cylinder",
        S::GeomAbs_Cone => "cone",
        S::GeomAbs_Sphere => "sphere",
        S::GeomAbs_Torus => "torus",
        S::GeomAbs_BezierSurface => "bezier",
        S::GeomAbs_BSplineSurface => "bspline",
        S::GeomAbs_SurfaceOfRevolution => "revolution",
        S::GeomAbs_SurfaceOfExtrusion => "extrusion",
        S::GeomAbs_OffsetSurface => "offset",
        _ => "other",
    }
}

impl fmt::Debug for Shape {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{self}")
    }
}

impl fmt::Display for Shape {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let kind = self.shape_type();
        match kind {
            ShapeType::Vertex => {
                let at = self.point().map(fmt_vec).unwrap_or_default();
                write!(f, "Shape(vertex at {at})")
            },
            ShapeType::Edge => {
                write!(f, "Shape(edge, {})", self.geom_type().unwrap_or("unknown"))
            },
            _ => write!(
                f,
                "Shape({kind}, {} faces, {} edges, {} vertices)",
                self.faces().len(),
                self.edges().len(),
                self.vertices().len()
            ),
        }
    }
}

type Raw = ffi::topo_ds::TopoDS_Shape;

/// One of the non-destructive boolean bindings, e.g. `BRepAlgoAPI_fuse`.
type BooleanFn = fn(
    &Raw,
    &Raw,
    &ffi::message::Message_ProgressRange,
    &mut String,
) -> std::result::Result<UniquePtr<Raw>, cxx::Exception>;

fn valid(shape: &Raw) -> bool {
    ffi::b_rep_check::BRepCheck_Analyzer_new(shape).map(|a| a.IsValid()).unwrap_or(false)
}

/// A boolean's result given what its checks found: an error for a problem, and for checks that
/// could not run, as a result they can't vouch for is not used.
fn checked(name: &str, outcome: Result<Option<String>>) -> Result<()> {
    match outcome {
        Ok(None) => Ok(()),
        Ok(Some(problem)) => Err(invalid(problem)),
        Err(Error::Cancelled) => Err(Error::Cancelled),
        Err(e) => Err(invalid(format!(
            "the {name} could not be checked, so its result is not used: {e}. That usually comes \
             from faces that graze or nearly coincide, such as a tool whose edge runs along a bore \
             of the same radius: make the tool overlap the faces it meets clearly, by a few \
             hundredths of a millimetre or more"
        ))),
    }
}

/// What is wrong with a boolean `name` ("fuse", "cut" or "common") that returned a volume of
/// `got`, if no correct result could have it: one that isn't between `lower` and `upper`. A fuse
/// is at least the volume of one of the solids it fused and at most their sum; a cut at most the
/// volume it cut from, and at least that less the tool's; a common at most either side's. The
/// volumes are exact to about 1e-7, so a millionth of the largest is allowed for.
fn impossible_volume(name: &str, got: f64, lower: f64, upper: f64) -> Option<String> {
    const SLACK: f64 = 1e-6;
    let slack = SLACK * upper.max(lower.abs());
    let expected = if got < lower - slack {
        match name {
            "fuse" => format!("at least {lower:.6}, the volume of one of the solids it fused"),
            _ => format!(
                "at least {lower:.6}, the volume it cut from less that of what it was cut by"
            ),
        }
    } else if got > upper + slack {
        match name {
            "fuse" => format!("at most {upper:.6}, the volumes of the solids it fused together"),
            "cut" => format!("at most {upper:.6}, the volume it cut from"),
            _ => format!("at most {upper:.6}, the volume of one side"),
        }
    } else {
        return None;
    };
    Some(format!(
        "the {name} returned a volume of {got:.6} where it must be {expected}: OpenCASCADE's \
         boolean went wrong without an error, which happens where faces graze or nearly \
         coincide. Make the shapes overlap clearly, and make tools run past the ends of what they \
         join or cut rather than ending inside or flush with it"
    ))
}

/// Why a boolean that returned an invalid shape failed, given the warnings it raised, such as
/// "BOPAlgo_AlertAcquiredSelfIntersection,BOPAlgo_AlertTooSmallEdge", and whether the shapes it
/// was given were valid.
fn invalid_boolean(name: &str, warnings: &str, inputs_valid: bool) -> String {
    let words: Vec<String> = warnings
        .split(',')
        .filter(|w| !w.is_empty())
        .map(|w| {
            let w = w.trim_start_matches("BOPAlgo_Alert");
            let mut out = String::new();
            for (i, c) in w.chars().enumerate() {
                if c.is_uppercase() && i > 0 {
                    out.push(' ');
                }
                out.extend(c.to_lowercase());
            }
            out
        })
        .collect();
    let reported = match words.is_empty() {
        true => String::new(),
        false => format!(" (OpenCASCADE reported: {})", words.join(", ")),
    };
    if !inputs_valid {
        return format!(
            "the {name} returned an invalid shape{reported}: one of the shapes it was given was \
             invalid already. Check each with is_valid() to find the operation that broke it"
        );
    }
    format!(
        "the {name} returned an invalid shape{reported}, which OpenCASCADE's checker rejects. \
         This usually comes from faces that only touch or nearly coincide: make the shapes \
         overlap clearly, by a few hundredths of a millimetre or more"
    )
}

#[derive(Clone, Copy)]
enum Blend {
    Fillet,
    Chamfer,
}

impl Blend {
    /// The operation's name and what it does to an edge.
    fn words(self) -> (&'static str, &'static str) {
        match self {
            Blend::Fillet => ("fillet", "round"),
            Blend::Chamfer => ("chamfer", "bevel"),
        }
    }
}

impl Blend {
    /// What the size of the fillet or chamfer is called.
    fn measure(self) -> &'static str {
        match self {
            Blend::Fillet => "radius",
            Blend::Chamfer => "distance",
        }
    }
}

/// "the selected edge" or "the 3 selected edges".
fn selected(edges: usize) -> String {
    if edges == 1 {
        "the selected edge".to_string()
    } else {
        format!("the {edges} selected edges")
    }
}

/// Why a fillet or chamfer that gave an invalid solid failed, and what to try instead.
fn blend_invalid(kind: Blend, size: f64, edges: usize, input_valid: bool) -> String {
    let ((what, verb), measure, count) = (kind.words(), kind.measure(), selected(edges));
    if !input_valid {
        return format!(
            "{what} failed: a {what} of {count} gave an invalid solid, as the shape it was given \
             was invalid already. Check the shapes it was built from with is_valid() to find the \
             operation that broke it"
        );
    }
    format!(
        "{what} failed: a {what} of {count} with {measure} {size} gave an invalid solid, which \
         OpenCASCADE's checker rejects. Usually the {measure} is too large for a face next to one \
         of the edges, such as a chamfer wider than a rounded corner beside it. Try a smaller \
         {measure}, or {verb} fewer edges at a time"
    )
}

/// What to do when a fillet or chamfer fails on a shape whose faces a boolean split.
fn blend_split(kind: Blend, size: f64) -> String {
    let (what, verb) = kind.words();
    format!(
        "The shape's faces are also split along edges that are no corner, as a boolean leaves \
         them where it fuses faces that continue each other (a boss's top flush with a plate's, \
         say), and OpenCASCADE can't {verb} edges that meet those: merge the faces with clean() \
         first, and select the edges on the cleaned shape, as clean() renumbers them: let part = \
         part.clean(); part.{what}({size}, part.edges(\">Z\"))"
    )
}

/// Why a fillet or chamfer failed, and what to try instead.
fn blend_failed(kind: Blend, size: f64, edges: usize) -> String {
    let ((what, verb), measure, count) = (kind.words(), kind.measure(), selected(edges));
    format!(
        "{what} failed: OpenCASCADE could not {verb} {count} with {measure} {size}. Usually the \
         {measure} is too large for a face next to one of the edges, or an edge ends in a corner \
         the {what} can't close. Try a smaller {measure}, or {verb} fewer edges at a time (for \
         example the vertical edges first, then the top ones)"
    )
}

/// An exception from `operation`, or [`Error::Cancelled`] when it was asked to stop.
fn occt_error(operation: &str, exception: cxx::Exception) -> Error {
    match Error::from(exception) {
        Error::Occt(message) => Error::Occt(format!("{operation}: {message}")),
        other => other,
    }
}

impl PartialEq for Shape {
    /// Shapes are equal when they share the same underlying topology.
    fn eq(&self, other: &Self) -> bool {
        self.is_same(other)
    }
}

/// What [`Shape::mass_properties`] measures.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct MassProperties {
    /// The enclosed volume (0 for shapes without solids).
    pub volume: f64,
    /// The total area of all faces.
    pub area: f64,
    /// The center of mass, as [`Shape::center`] finds it.
    pub center: DVec3,
}

/// OpenCASCADE's optimal bounding box of a shape, or `None` for an empty one.
fn optimal_box(shape: &Raw) -> Result<Option<BoundingBox>> {
    let mut bnd = ffi::bnd::Bnd_Box_new();
    ffi::b_rep_bnd_lib::BRepBndLib::AddOptimal(shape, bnd.pin_mut(), false, false)?;
    if bnd.IsVoid() {
        return Ok(None);
    }
    let min = from_pnt(&*ffi::bnd::Bnd_Box_CornerMin(&bnd)?);
    let max = from_pnt(&*ffi::bnd::Bnd_Box_CornerMax(&bnd)?);
    Ok(Some(BoundingBox { min, max }))
}

fn shell_failed(shape: &Shape, thickness: f64) -> Error {
    let free_form = shape
        .faces()
        .iter()
        .any(|f| matches!(f.geom_type(), Ok("bspline" | "bezier" | "offset" | "other")));
    let hint = if free_form {
        "Lofted, swept and spline faces often can't be offset: build the inside as its own \
         smaller shape that runs past the open ends, and subtract it"
    } else {
        "The usual cause is a fillet or other curved face tighter than the wall: shelling inward \
         needs every fillet radius it offsets to exceed the thickness. Use a thinner wall or \
         larger fillets, or shell first and fillet the outside edges afterwards"
    };
    invalid(format!("shell failed: OpenCASCADE could not offset the faces by {thickness}. {hint}"))
}

/// How many shapes' Bézier splits [`Shape::for_measuring`] keeps.
const KEPT_SPLITS: usize = 4;

/// A copy of a shape moved rigidly, the shape it was copied from, and the motion between them.
type RigidCopy = (Shape, Shape, Rc<UniquePtr<ffi::top_loc::TopLoc_Location>>);

/// How many rigid copies [`COPIES`] remembers: enough for the patterns scripts make. Each keeps
/// its two shapes alive until it is dropped for a newer one.
const KEPT_COPIES: usize = 256;

thread_local! {
    /// The shapes last split for measuring, with their splits, oldest first. Shapes never leave
    /// their thread, so neither do these.
    static SPLITS: std::cell::RefCell<Vec<(Shape, Shape)>> = const {
        std::cell::RefCell::new(Vec::new())
    };

    /// The last rigid copies made, oldest first.
    static COPIES: std::cell::RefCell<Vec<RigidCopy>> = const {
        std::cell::RefCell::new(Vec::new())
    };
}

/// An axis-aligned bounding box.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct BoundingBox {
    pub min: DVec3,
    pub max: DVec3,
}

impl BoundingBox {
    pub fn center(&self) -> DVec3 {
        (self.min + self.max) / 2.0
    }

    pub fn size(&self) -> DVec3 {
        self.max - self.min
    }

    /// Whether `p` lies inside the box (boundary included).
    pub fn contains(&self, p: DVec3) -> bool {
        p.cmpge(self.min).all() && p.cmple(self.max).all()
    }
}

impl fmt::Display for BoundingBox {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "BoundingBox(min: {}, max: {})", fmt_vec(self.min), fmt_vec(self.max))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn impossible_boolean_volumes() {
        assert_eq!(impossible_volume("fuse", 8.0, 8.0, 12.0), None);
        assert_eq!(impossible_volume("fuse", 12.0, 8.0, 12.0), None);
        let fuse = impossible_volume("fuse", 7.999, 8.0, 12.0).unwrap();
        assert!(fuse.contains("a volume of 7.999000 where it must be at least 8.000000"), "{fuse}");
        let fuse = impossible_volume("fuse", 12.1, 8.0, 12.0).unwrap();
        assert!(fuse.contains("at most 12.000000, the volumes of the solids it fused"), "{fuse}");
        assert_eq!(impossible_volume("cut", 8.0, 4.0, 8.0), None);
        let cut = impossible_volume("cut", 8.001, 4.0, 8.0).unwrap();
        assert!(cut.contains("at most 8.000000, the volume it cut from"), "{cut}");
        let cut = impossible_volume("cut", 3.9, 4.0, 8.0).unwrap();
        assert!(
            cut.contains("at least 4.000000, the volume it cut from less that of what"),
            "{cut}"
        );
        assert_eq!(impossible_volume("cut", 0.0, f64::NEG_INFINITY, 8.0), None);
        assert_eq!(impossible_volume("common", 4.0, 0.0, 4.0), None);
        let common = impossible_volume("common", 4.001, 0.0, 4.0).unwrap();
        assert!(common.contains("at most 4.000000, the volume of one side"), "{common}");
    }

    #[test]
    fn checks_that_cannot_run_reject_the_result() {
        assert!(checked("fuse", Ok(None)).is_ok());
        let m = checked("cut", Ok(Some("wrong".into()))).unwrap_err().to_string();
        assert!(m.ends_with("wrong"), "{m}");
        assert!(matches!(checked("cut", Err(Error::Cancelled)), Err(Error::Cancelled)));
        let m = checked("cut", Err(invalid("no split"))).unwrap_err().to_string();
        assert!(m.contains("the cut could not be checked, so its result is not used"), "{m}");
        assert!(m.contains("no split"), "{m}");
    }

    #[test]
    fn faces_that_are_not_smooth_throughout_cannot_be_measured() {
        // A loft's side is one face with a knot at each inner section; its Bézier split isn't.
        let rings: Vec<Shape> = [(0.0, 5.0), (4.0, 6.0), (9.0, 4.0)]
            .iter()
            .map(|(z, r)| Shape::circle(DVec3::new(0.0, 0.0, *z), DVec3::Z, *r).unwrap())
            .collect();
        let lofted = Shape::loft(&rings, true).unwrap();
        let m = lofted.require_smooth_faces().unwrap_err().to_string();
        assert!(m.contains("can't be measured exactly: 1 of its faces could not be split"), "{m}");
        assert!(lofted.split_for_measuring().is_ok());
    }

    #[test]
    fn rigid_copies_are_measured_through_their_source() {
        let rings: Vec<Shape> = [(0.0, 5.0), (4.0, 6.0), (9.0, 4.0)]
            .iter()
            .map(|(z, r)| Shape::circle(DVec3::new(0.0, 0.0, *z), DVec3::Z, *r).unwrap())
            .collect();
        let lofted = Shape::loft(&rings, true).unwrap();
        let moved = lofted.rotate(DVec3::ZERO, DVec3::X, 30.0).unwrap();
        let moved = moved.translate(DVec3::new(5.0, -2.0, 7.0)).unwrap();
        // A deep copy shares nothing, so it is split and measured on its own.
        let alone = moved.deep_copy().unwrap();
        let (a, b) = (moved.mass_properties().unwrap(), alone.mass_properties().unwrap());
        assert!((a.volume - b.volume).abs() <= 1e-9 * b.volume, "{} {}", a.volume, b.volume);
        assert!((a.area - b.area).abs() <= 1e-9 * b.area, "{} {}", a.area, b.area);
        assert!((a.center - b.center).length() <= 1e-9, "{} {}", a.center, b.center);
        SPLITS.with_borrow(|splits| {
            assert!(splits.iter().any(|(shape, _)| shape.is_same(&lofted)));
            assert!(!splits.iter().any(|(shape, _)| shape.is_same(&moved)));
        });
        // A scaled copy isn't a rigid one: it is split itself.
        let scaled = lofted.scale(DVec3::ZERO, 2.0).unwrap();
        let v = scaled.volume().unwrap();
        assert!((v - 8.0 * lofted.volume().unwrap()).abs() <= 1e-6 * v, "{v}");
        SPLITS
            .with_borrow(|splits| assert!(splits.iter().any(|(shape, _)| shape.is_same(&scaled))));
    }

    /// A boolean's checks against a result made up to be wrong in each way they catch.
    #[test]
    fn checks_catch_each_kind_of_wrong_result() {
        // Overlapping by a corner, through which each has edges inside the other.
        let a = Shape::cube(10.0).unwrap();
        let b = Shape::cube(10.0).unwrap().translate(DVec3::splat(5.0)).unwrap();
        let empty = Shape::compound(&[]).unwrap();
        let problem =
            |name: &str, result: &Shape| a.volume_problem(&b, name, result.raw()).unwrap();
        let small = Shape::make_box(5.0, 5.0, 5.0).unwrap();
        let big = Shape::make_box(20.0, 20.0, 20.0).unwrap();
        assert!(problem("fuse", &small).unwrap().contains("must be at least 1000"));
        assert!(problem("fuse", &big).unwrap().contains("must be at most 2000"));
        let apart = Shape::compound(&[a.clone(), b.clone()]).unwrap();
        assert!(problem("fuse", &apart).unwrap().contains("left them as separate, overlapping"));
        assert!(problem("cut", &big).unwrap().contains("must be at most 1000"));
        assert!(problem("cut", &a).unwrap().contains("the cut removed nothing"));
        // A slab 2 thick cut from the cube leaves 800 of its 1000, not 400.
        let slab = Shape::make_box(2.0, 10.0, 10.0).unwrap().translate(DVec3::new(4.0, 0.0, 0.0));
        let left = Shape::make_box(4.0, 10.0, 10.0).unwrap();
        let m = a.volume_problem(&slab.unwrap(), "cut", left.raw()).unwrap().unwrap();
        assert!(m.contains("a volume of 400.000000 where it must be at least 800.000000"), "{m}");
        assert!(problem("cut", &empty).unwrap().contains("the cut removed everything"));
        assert!(problem("common", &empty).unwrap().contains("found nothing in common"));
        assert!(problem("common", &big).unwrap().contains("must be at most 1000"));
        // The right answers pass.
        assert_eq!(problem("fuse", &a.fuse(&b).unwrap()), None);
        assert_eq!(problem("cut", &a.cut(&b).unwrap()), None);
        assert_eq!(problem("common", &a.common(&b).unwrap()), None);
    }

    #[test]
    fn invalid_boolean_messages() {
        let warned = "BOPAlgo_AlertAcquiredSelfIntersection,BOPAlgo_AlertTooSmallEdge";
        let m = invalid_boolean("fuse", warned, true);
        assert!(m.contains("(OpenCASCADE reported: acquired self intersection, too small edge)"));
        assert!(m.contains("overlap clearly"), "{m}");
        let m = invalid_boolean("cut", "", false);
        assert!(m.starts_with("the cut returned an invalid shape: one of the shapes"), "{m}");
    }
    use ffi::geom_abs::{GeomAbs_CurveType as C, GeomAbs_SurfaceType as S};

    #[test]
    fn every_curve_type_has_a_name() {
        let cases = [
            (C::GeomAbs_Line, "line"),
            (C::GeomAbs_Circle, "circle"),
            (C::GeomAbs_Ellipse, "ellipse"),
            (C::GeomAbs_Hyperbola, "hyperbola"),
            (C::GeomAbs_Parabola, "parabola"),
            (C::GeomAbs_BezierCurve, "bezier"),
            (C::GeomAbs_BSplineCurve, "bspline"),
            (C::GeomAbs_OffsetCurve, "offset"),
            (C::GeomAbs_OtherCurve, "other"),
        ];
        for (kind, name) in cases {
            assert_eq!(curve_type_name(kind), name);
        }
    }

    #[test]
    fn every_surface_type_has_a_name() {
        let cases = [
            (S::GeomAbs_Plane, "plane"),
            (S::GeomAbs_Cylinder, "cylinder"),
            (S::GeomAbs_Cone, "cone"),
            (S::GeomAbs_Sphere, "sphere"),
            (S::GeomAbs_Torus, "torus"),
            (S::GeomAbs_BezierSurface, "bezier"),
            (S::GeomAbs_BSplineSurface, "bspline"),
            (S::GeomAbs_SurfaceOfRevolution, "revolution"),
            (S::GeomAbs_SurfaceOfExtrusion, "extrusion"),
            (S::GeomAbs_OffsetSurface, "offset"),
            (S::GeomAbs_OtherSurface, "other"),
        ];
        for (kind, name) in cases {
            assert_eq!(surface_type_name(kind), name);
        }
    }

    #[test]
    fn every_shape_type_round_trips_through_ffi_and_names() {
        for kind in ShapeType::ALL {
            assert_eq!(ShapeType::from_ffi(kind.to_ffi()), kind);
            assert_eq!(ShapeType::parse(kind.name()).unwrap(), kind);
            assert_eq!(kind.to_string(), kind.name());
        }
        assert_eq!(ShapeType::parse(" SOLID ").unwrap(), ShapeType::Solid);
        assert!(ShapeType::parse("blob").is_err());
        // Only null shapes report TopAbs_SHAPE; it maps to the catch-all.
        assert_eq!(
            ShapeType::from_ffi(ffi::top_abs::TopAbs_ShapeEnum::TopAbs_SHAPE),
            ShapeType::Compound
        );
    }
}
