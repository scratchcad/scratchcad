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

    /// A full circle as a closed edge.
    pub fn circle_edge(center: DVec3, normal: DVec3, radius: f64) -> Result<Self> {
        Self::circle_edge_around(&*axis2(center, normal)?, radius)
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
    /// automatically unless the last point equals the first).
    pub fn polygon(points: &[DVec3]) -> Result<Self> {
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

    /// A polygon given in the coordinates of `plane`.
    pub fn polygon_on(plane: &Plane, points: &[DVec2]) -> Result<Self> {
        Self::polygon(&points.iter().map(|p| plane.to_world(*p)).collect::<Vec<_>>())
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
                Self::from_raw(make.pin_mut().Shape()?)
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
            _ => Ok(face),
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
    /// A boolean can succeed and still return an invalid shape (where faces only touch or
    /// nearly coincide, say), which later operations then mangle or drop without an error. A
    /// healthy boolean raises no warnings, so when one does, the result is checked, and an invalid
    /// one is recorded as a note (see [`take_notes`](crate::take_notes)).
    fn boolean(&self, other: &Shape, name: &'static str, run: BooleanFn) -> Result<UniquePtr<Raw>> {
        let mut warnings = String::new();
        let result = run(self.raw(), other.raw(), &progress(), &mut warnings)?;
        if result.is_null() {
            return Err(failed(name));
        }
        if !warnings.is_empty() && !valid(&result) {
            crate::notes::note(invalid_boolean(name, &warnings));
        } else if let Some(problem) = self.volume_problem(other, name, &result)? {
            crate::notes::note(problem);
        }
        Ok(result)
    }

    /// What is wrong with a boolean's result whose volume no correct result could have: a fuse
    /// smaller than one of the solids it fused, or a cut or common larger than the solids it was
    /// cut from. OpenCASCADE returns such results without an error or a warning where faces graze
    /// or nearly coincide (a lofted thread ridge running out past the end of its core lost the
    /// core's volume to it). The volumes come first from integrating the solids directly, which is
    /// fast and usually within a percent or so, but can be far off on long B-spline lofts (30% on
    /// a 42-turn thread groove). A volume that looks impossible is measured again exactly, on
    /// copies, as measuring splits faces in place, and noted only if it still is.
    fn volume_problem(&self, other: &Shape, name: &str, result: &Raw) -> Result<Option<String>> {
        let volumes = |shape: &Shape| -> Result<Vec<f64>> {
            shape.solids().iter().map(|s| Ok(s.volume_props()?.Mass().abs())).collect()
        };
        let (a, b) = (volumes(self)?, volumes(other)?);
        if a.is_empty() || b.is_empty() || name == "section" {
            return Ok(None);
        }
        let result = Self::from_raw(result)?;
        let got = result.volume_props()?.Mass().abs();
        if let Some(problem) = impossible_volume(name, got, &a, &b) {
            // Where the shapes can't be measured exactly, the direct integration stands.
            let confirmed = self.exact_volume_problem(other, name, &result);
            if let Some(problem) = confirmed.unwrap_or(Some(problem)) {
                return Ok(Some(problem));
            }
        }
        // OpenCASCADE can also miss that two solids meet at all, and then fuse them into a
        // compound of the two overlapping solids, cut nothing, or find nothing in common. Where a
        // result looks like that, a point on an edge of either shape strictly inside the other
        // proves they did overlap.
        // A cut that missed can still split faces along where the shapes meet, which moves the
        // integrated volume by a few parts in 1e8 (a helical groove cut from a cylinder), so
        // "removed nothing" means less than a millionth of the smaller side.
        let (sum_a, sum_b) = (a.iter().sum::<f64>(), b.iter().sum::<f64>());
        let untouched = match name {
            "fuse" => result.solids().len() == a.len() + b.len(),
            "cut" => (got - sum_a).abs() <= 1e-6 * sum_a.min(sum_b),
            _ => result.solids().is_empty(),
        };
        // A cut can also go the other way and remove everything, although part of the shape lies
        // outside the tool: a point on its edges strictly outside the tool proves that.
        if name == "cut" && result.solids().is_empty() && self.reaches_outside(other)? {
            return Ok(Some(format!(
                "the cut removed everything, although part of the shape lies outside what it was \
                 cut by: OpenCASCADE's boolean went wrong, which happens where faces graze or \
                 nearly coincide. Make the tool clearly smaller or clearly larger than the shape \
                 where their faces meet ({sum_a:.6} and {sum_b:.6} of volume)"
            )));
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
                 past the ends of what they join or cut rather than ending inside or flush with it \
                 ({:.6} and {:.6} of volume)",
                sum_a, sum_b
            )));
        }
        Ok(None)
    }

    /// [`impossible_volume`] of a boolean `name` of this shape and `other` that gave `result`,
    /// measured exactly on copies of the three.
    fn exact_volume_problem(
        &self,
        other: &Shape,
        name: &str,
        result: &Shape,
    ) -> Result<Option<String>> {
        let exact = |shape: &Shape| -> Result<Vec<f64>> {
            shape.solids().iter().map(|s| s.deep_copy()?.volume()).collect()
        };
        let got = result.deep_copy()?.volume()?;
        Ok(impossible_volume(name, got, &exact(self)?, &exact(other)?))
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
            if let Ok(bounds) = solid.bounding_box() {
                targets.push((solid.clone(), bounds));
            }
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

    /// The union of all shapes.
    pub fn fuse_all(shapes: &[Shape]) -> Result<Self> {
        let (first, rest) =
            shapes.split_first().ok_or_else(|| invalid("fuse_all needs at least one shape"))?;
        rest.iter().try_fold(first.clone(), |acc, shape| acc.fuse(shape))
    }

    // ---------------------------------------------------------------------------------------
    // Transforms
    // ---------------------------------------------------------------------------------------

    fn transformed(&self, transform: &ffi::gp::gp_Trsf) -> Result<Self> {
        let mut make =
            ffi::b_rep_builder_api::BRepBuilderAPI_Transform_new(self.raw(), transform, true)?;
        Self::from_raw(make.pin_mut().Shape()?)
    }

    pub fn translate(&self, delta: DVec3) -> Result<Self> {
        if !delta.is_finite() {
            return Err(invalid(format!("translation must be finite, got {}", fmt_vec(delta))));
        }
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().set_translation_vec(&vector(delta));
        self.transformed(&transform)
    }

    /// Rotates around the axis through `origin` along `axis` by `degrees` (right-hand rule).
    pub fn rotate(&self, origin: DVec3, axis: DVec3, degrees: f64) -> Result<Self> {
        require_finite(degrees, "rotation angle")?;
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().SetRotation(&*axis1(origin, axis)?, degrees.to_radians());
        self.transformed(&transform)
    }

    /// Scales uniformly about `center`. The factor must be non-zero (negative factors mirror).
    pub fn scale(&self, center: DVec3, factor: f64) -> Result<Self> {
        require_finite(factor, "scale factor")?;
        if factor.abs() < EPSILON {
            return Err(invalid("scale factor must not be zero"));
        }
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().SetScale(&point(center), factor);
        self.transformed(&transform)
    }

    /// Mirrors through the plane with the given origin and normal.
    pub fn mirror(&self, origin: DVec3, normal: DVec3) -> Result<Self> {
        let mut transform = ffi::gp::new_transform();
        transform.pin_mut().set_mirror_plane(&*axis2(origin, normal)?);
        self.transformed(&transform)
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
        let mut make =
            ffi::b_rep_offset_api::BRepOffsetAPI_MakePipe_new(spine.wire()?, profile.raw())?;
        if !make.IsDone() {
            return Err(Error::OperationFailed("sweep"));
        }
        Self::from_algorithm(make.pin_mut().Shape()?)
    }

    /// A shape passing through all sections (wires, or faces whose outer wire is used).
    pub fn loft(sections: &[Shape], solid: bool) -> Result<Self> {
        if sections.len() < 2 {
            return Err(invalid("a loft needs at least 2 sections"));
        }
        // OpenCASCADE 7.8 ignores the progress range of lofts, fillets and chamfers, so they
        // cannot be interrupted once started; at least do not start them after a cancel.
        crate::cancel::check()?;
        let mut make = ffi::b_rep_offset_api::BRepOffsetAPI_ThruSections_new(solid);
        for section in sections {
            let wire = match section.shape_type() {
                ShapeType::Face => section.outer_wire()?,
                ShapeType::Edge => Self::wire_from(std::slice::from_ref(section))?,
                _ => section.clone(),
            };
            make.pin_mut().AddWire(wire.wire()?)?;
        }
        make.pin_mut().Build(&progress())?;
        if !make.IsDone() {
            return Err(failed("loft"));
        }
        Self::from_algorithm(make.pin_mut().Shape()?)
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
        crate::cancel::check()?;
        let mut make = ffi::b_rep_fillet_api::BRepFilletAPI_MakeFillet_new(self.raw())?;
        for edge in edges {
            make.pin_mut().add_edge(radius, edge.edge()?)?;
        }
        make.pin_mut().Build(&progress()).map_err(|e| occt_error("fillet", e))?;
        if !make.IsDone() {
            return Err(failed("fillet"));
        }
        Self::from_algorithm(make.pin_mut().Shape()?)
    }

    /// Rounds every edge.
    pub fn fillet_all(&self, radius: f64) -> Result<Self> {
        self.fillet(radius, self.edges().shapes())
    }

    /// Bevels the given edges of a solid with equal distances.
    pub fn chamfer(&self, distance: f64, edges: &[Shape]) -> Result<Self> {
        require_positive(distance, "chamfer distance")?;
        self.require_edges(edges, "chamfer")?;
        crate::cancel::check()?;
        let mut make = ffi::b_rep_fillet_api::BRepFilletAPI_MakeChamfer_new(self.raw())?;
        for edge in edges {
            make.pin_mut().add_edge(distance, edge.edge()?)?;
        }
        make.pin_mut().Build(&progress()).map_err(|e| occt_error("chamfer", e))?;
        if !make.IsDone() {
            return Err(failed("chamfer"));
        }
        Self::from_algorithm(make.pin_mut().Shape()?)
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
        if thickness < 0.0 {
            self.cut(&thick)
        } else {
            thick.cut(self)
        }
    }

    fn thick_solid(&self, thickness: f64, open_faces: &[Shape]) -> Result<Self> {
        let mut faces = ffi::top_tools::new_list_of_shape();
        for face in open_faces {
            faces.pin_mut().Append(face.raw());
        }
        let mut make = ffi::b_rep_offset_api::BRepOffsetAPI_MakeThickSolid_new();
        make.pin_mut().MakeThickSolidByJoin(
            self.raw(),
            &faces,
            thickness,
            1e-3,
            ffi::b_rep_offset_api::BRepOffset_Mode::BRepOffset_Skin,
            false,
            false,
            ffi::geom_abs::GeomAbs_JoinType::GeomAbs_Arc,
            false,
            &progress(),
        )?;
        if !make.IsDone() {
            return Err(failed("shell"));
        }
        Self::from_algorithm(make.pin_mut().Shape()?)
    }

    /// Offsets a planar wire or face within its plane (positive grows it). A face keeps its
    /// holes; an offset that splits the shape into separate regions is an error.
    pub fn offset_2d(&self, distance: f64) -> Result<Self> {
        require_finite(distance, "offset distance")?;
        let join = ffi::geom_abs::GeomAbs_JoinType::GeomAbs_Arc;
        let mut make = match self.shape_type() {
            ShapeType::Face => {
                ffi::b_rep_offset_api::BRepOffsetAPI_MakeOffset_face_new(self.face()?, join)?
            },
            ShapeType::Wire => {
                // Offsetting the face keeps the orientation consistent: positive grows outwards.
                let face = Self::face_from(self)?;
                let offset = face.offset_2d(distance)?;
                return offset.wires().first();
            },
            other => {
                return Err(Error::WrongShapeType {
                    expected: "wire or face",
                    actual: other.name(),
                })
            },
        };
        make.pin_mut().Perform(distance, 0.0)?;
        if !make.IsDone() {
            return Err(Error::OperationFailed("offset"));
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
            return Err(Error::OperationFailed("offset"));
        };
        let hole_area: f64 = holes.iter().map(|(area, _)| area).sum();
        let holes: Vec<Self> = holes.iter().map(|(_, wire)| wire.clone()).collect();
        let face = Self::face_with_holes(outer, &holes)?;
        if (face.area()? - (outer_area - hole_area)).abs() > 1e-6 * outer_area {
            return Err(invalid(format!(
                "an offset of {distance} splits the shape into separate regions; shrink it by less"
            )));
        }
        Ok(face)
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

    /// The shape to measure: itself when all its geometry is analytic (lines, conics, planes,
    /// cylinders, cones, spheres and tori), and otherwise a copy split into Bézier pieces, one
    /// per span of every B-spline curve and surface. OpenCASCADE integrates each face at a fixed
    /// number of Gauss points: exact for analytic faces, but off by percent on lofts, sweeps and
    /// extruded splines, whose faces have many spans. On a single Bézier patch the same
    /// integration is accurate, to about 1e-7. (Its adaptive integrations report a tiny error on
    /// such faces while getting them wrong, and can take minutes.) Fails if the conversion
    /// does, rather than measuring the shape wrong.
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
        Self::from_unique(ffi::shape_upgrade::ShapeUpgrade_convert_to_bezier(self.raw())?)
    }

    /// The enclosed volume (0 for shapes without solids).
    pub fn volume(&self) -> Result<f64> {
        Ok(self.for_measuring()?.volume_props()?.Mass().abs())
    }

    /// The total area of all faces.
    pub fn area(&self) -> Result<f64> {
        Ok(self.for_measuring()?.surface_props()?.Mass())
    }

    /// The volume, area and center of mass together, which splits the shape for measuring
    /// once instead of three times.
    pub fn mass_properties(&self) -> Result<MassProperties> {
        let exact = self.for_measuring()?;
        Ok(MassProperties {
            volume: exact.volume_props()?.Mass().abs(),
            area: exact.surface_props()?.Mass(),
            center: exact.center_of_mass()?,
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
    pub fn bounding_box(&self) -> Result<BoundingBox> {
        let mut bnd = ffi::bnd::Bnd_Box_new();
        ffi::b_rep_bnd_lib::BRepBndLib::AddOptimal(self.raw(), bnd.pin_mut(), false, false)?;
        if bnd.IsVoid() {
            return Err(invalid("an empty shape has no bounding box"));
        }
        let min = from_pnt(&*ffi::bnd::Bnd_Box_CornerMin(&bnd)?);
        let max = from_pnt(&*ffi::bnd::Bnd_Box_CornerMax(&bnd)?);
        Ok(BoundingBox { min, max })
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
        let face = self.face()?;
        let center = self.center()?;
        let surface = ffi::b_rep::BRep_Tool_Surface(face)?;
        let projector = ffi::geom_api::GeomAPI_ProjectPointOnSurf_new(&point(center), &surface)?;
        let (mut u, mut v) = (0.0, 0.0);
        if ffi::geom_api::GeomAPI_ProjectPointOnSurf_LowerDistanceParameters(
            &projector, &mut u, &mut v,
        )
        .is_err()
        {
            // Projection can fail for degenerate surfaces; the middle of the face's parameter
            // range is a reasonable fallback.
            let adaptor = ffi::b_rep_adaptor::BRepAdaptor_Surface_new(face, true)?;
            u = (adaptor.FirstUParameter() + adaptor.LastUParameter()) / 2.0;
            v = (adaptor.FirstVParameter() + adaptor.LastVParameter()) / 2.0;
        }
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

/// What is wrong with a boolean `name` ("fuse", "cut" or "common") that returned a volume of
/// `got` from arguments whose solids have the volumes `a` and `b`, if no correct result could
/// have that volume.
fn impossible_volume(name: &str, got: f64, a: &[f64], b: &[f64]) -> Option<String> {
    let largest = a.iter().chain(b).fold(0.0f64, |m, v| m.max(*v));
    let (sum_a, sum_b) = (a.iter().sum::<f64>(), b.iter().sum::<f64>());
    let expected = match name {
        "fuse" if got < 0.95 * largest => {
            format!("at least {largest:.6}, the volume of the largest solid it fused")
        },
        "cut" if got > 1.05 * sum_a => format!("at most {sum_a:.6}, the volume it cut from"),
        "common" if got > 1.05 * sum_a.min(sum_b) => {
            format!("at most {:.6}, the volume of the smaller side", sum_a.min(sum_b))
        },
        _ => return None,
    };
    Some(format!(
        "the {name} returned a volume of {got:.6} where it must be {expected}: OpenCASCADE's \
         boolean went wrong without an error, which happens where faces graze or nearly \
         coincide. Make the shapes overlap clearly, and make tools run past the ends of what they \
         join or cut rather than ending inside or flush with it"
    ))
}

/// The note for a boolean that returned an invalid shape, given the warnings it raised, such as
/// "BOPAlgo_AlertAcquiredSelfIntersection,BOPAlgo_AlertTooSmallEdge".
fn invalid_boolean(name: &str, warnings: &str) -> String {
    let words: Vec<String> = warnings
        .split(',')
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
    format!(
        "the {name} returned an invalid shape (OpenCASCADE reported: {}), which later operations \
         may mangle or silently drop. This usually comes from faces that only touch or nearly \
         coincide: make the shapes overlap clearly, by a few hundredths of a millimetre or more",
        words.join(", ")
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
        assert_eq!(impossible_volume("fuse", 10.0, &[8.0], &[4.0]), None);
        let fuse = impossible_volume("fuse", 7.0, &[8.0], &[4.0]).unwrap();
        assert!(fuse.contains("a volume of 7.000000 where it must be at least 8.000000"), "{fuse}");
        assert_eq!(impossible_volume("cut", 8.0, &[8.0], &[4.0]), None);
        let cut = impossible_volume("cut", 9.0, &[8.0], &[4.0]).unwrap();
        assert!(cut.contains("at most 8.000000, the volume it cut from"), "{cut}");
        assert_eq!(impossible_volume("common", 4.1, &[8.0], &[2.0, 2.0]), None);
        let common = impossible_volume("common", 5.0, &[8.0], &[2.0, 2.0]).unwrap();
        assert!(common.contains("at most 4.000000, the volume of the smaller side"), "{common}");
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
