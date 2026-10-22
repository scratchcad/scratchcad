//! Registration of every type and function with a Rhai [`Engine`].
//!
//! Script-facing conventions:
//!
//! * Numbers may be integers or floats: `box(10, 20, 2.5)`.
//! * Vectors may be `vec3(x, y, z)` values or arrays: `translate([0, 0, 5])`. Two-element
//!   arrays are points in a sketch plane (or have `z = 0`).
//! * Directions may additionally be axis names: `"X"`, `"-Z"`.
//! * Angles are in degrees.
//! * Arguments that pick faces or edges accept a selector string (`">Z"`), a `Selection`, a
//!   single `Shape` or an array of shapes.
//! * Every fallible function raises a catchable runtime error, tagged with its
//!   [`ErrorKind`](crate::ErrorKind).
//! * Scripts cannot read or write files; the host does that through the Rust API.

use crate::{
    error::{Error, Result as CrateResult},
    math::{parse_direction, Plane},
    mesh::{Mesh, MeshOptions},
    selection::Selection,
    shape::{BoundingBox, Shape, ShapeType},
    sketch::Sketch,
};
use glam::{DVec2, DVec3};
use rhai::{Array, Dynamic, Engine, EvalAltResult, FnPtr, NativeCallContext, FLOAT, INT};

type RhaiResult<T> = std::result::Result<T, Box<EvalAltResult>>;

fn invalid(message: impl Into<String>) -> Box<EvalAltResult> {
    Error::InvalidArgument(message.into()).into()
}

/// Converts an `INT` or `FLOAT` to `f64`.
pub fn number(value: &Dynamic, what: &str) -> RhaiResult<f64> {
    if let Ok(f) = value.as_float() {
        return Ok(f);
    }
    value
        .as_int()
        .map(|i| i as f64)
        .map_err(|actual| invalid(format!("{what} must be a number, got {actual}")))
}

fn numbers(array: &Array, what: &str) -> RhaiResult<Vec<f64>> {
    array.iter().map(|v| number(v, what)).collect()
}

/// Converts a `Vec3` or an array of 2 or 3 numbers to a vector.
pub fn vector(value: &Dynamic, what: &str) -> RhaiResult<DVec3> {
    if let Some(v) = value.clone().try_cast::<DVec3>() {
        return Ok(v);
    }
    if value.is_array() {
        let array = value.clone().into_array()?;
        return match numbers(&array, what)?.as_slice() {
            [x, y] => Ok(DVec3::new(*x, *y, 0.0)),
            [x, y, z] => Ok(DVec3::new(*x, *y, *z)),
            _ => Err(invalid(format!("{what} must have 2 or 3 components, got {}", array.len()))),
        };
    }
    Err(invalid(format!("{what} must be a vec3 or an array of numbers, got {}", value.type_name())))
}

/// Like [`vector`], but also accepts axis names such as `"X"` or `"-Z"`.
pub fn direction(value: &Dynamic, what: &str) -> RhaiResult<DVec3> {
    if value.is_string() {
        return Ok(parse_direction(&value.clone().into_string()?)?);
    }
    vector(value, what)
}

fn point_2d(value: &Dynamic, what: &str) -> RhaiResult<DVec2> {
    if let Some(v) = value.clone().try_cast::<DVec3>() {
        return Ok(v.truncate());
    }
    Ok(vector(value, what)?.truncate())
}

fn points(value: &Array, what: &str) -> RhaiResult<Vec<DVec3>> {
    value.iter().map(|p| vector(p, what)).collect()
}

fn points_2d(value: &Array, what: &str) -> RhaiResult<Vec<DVec2>> {
    value.iter().map(|p| point_2d(p, what)).collect()
}

fn plane(value: &Dynamic) -> RhaiResult<Plane> {
    if let Some(p) = value.clone().try_cast::<Plane>() {
        return Ok(p);
    }
    if value.is_string() {
        return Ok(Plane::named(&value.clone().into_string()?)?);
    }
    Err(invalid(format!("expected a Plane or a plane name like \"XY\", got {}", value.type_name())))
}

/// Converts a `Shape`, `Selection` or array of either into a list of shapes.
pub fn shapes(value: &Dynamic) -> RhaiResult<Vec<Shape>> {
    if let Some(shape) = value.clone().try_cast::<Shape>() {
        return Ok(vec![shape]);
    }
    if let Some(selection) = value.clone().try_cast::<Selection>() {
        return Ok(selection.shapes().to_vec());
    }
    if value.is_array() {
        let mut result = Vec::new();
        for item in value.clone().into_array()? {
            if item.is_array() {
                return Err(invalid("nested arrays of shapes are not supported"));
            }
            result.extend(shapes(&item)?);
        }
        return Ok(result);
    }
    Err(invalid(format!("expected shapes, got {}", value.type_name())))
}

/// Picks sub-shapes of `shape` with a selector string, or takes explicit shapes.
fn pick(shape: &Shape, kind: ShapeType, value: &Dynamic) -> RhaiResult<Vec<Shape>> {
    if value.is_string() {
        let selector = value.clone().into_string()?;
        return Ok(shape.subshapes(kind).select(&selector)?.shapes().to_vec());
    }
    shapes(value)
}

/// Converts a script's result into a single shape: shapes are returned as-is, selections,
/// arrays and sketches are grouped/closed into a shape.
pub fn to_shape(value: Dynamic) -> RhaiResult<Shape> {
    if let Some(shape) = value.clone().try_cast::<Shape>() {
        return Ok(shape);
    }
    if let Some(sketch) = value.clone().try_cast::<Sketch>() {
        return Ok(sketch.close()?);
    }
    if value.is::<Selection>() || value.is_array() {
        return Ok(Shape::compound(&shapes(&value)?)?);
    }
    Err(invalid(format!("the script must evaluate to a shape, got {}", value.type_name())))
}

fn shape_array(selection: &Selection) -> Array {
    selection.iter().cloned().map(Dynamic::from).collect()
}

fn vec_array(vectors: &[DVec3]) -> Array {
    vectors.iter().copied().map(Dynamic::from).collect()
}

/// Registers every type and function of this crate with `engine`.
///
/// Scripts get no filesystem access: nothing registered here reads or writes files, and the
/// engine's module resolver is replaced with one that resolves nothing, so `import "path"` cannot
/// load script files from disk (as `Engine::new`'s default resolver does). A script can only
/// model, measure and mesh. Reading and writing files is left to the host, through the Rust API
/// ([`Shape::to_bytes`], [`Shape::from_bytes`], [`Shape::export`] and friends); to give a script
/// a shape read from a file, push it into the script's `Scope`. To give scripts modules, set a
/// resolver of your own (such as Rhai's `StaticModuleResolver`) after calling this.
pub fn register(engine: &mut Engine) {
    engine.set_module_resolver(rhai::module_resolvers::DummyModuleResolver::new());
    register_vec3(engine);
    register_plane(engine);
    register_constructors(engine);
    register_shape(engine);
    register_selection(engine);
    register_sketch(engine);
    register_results(engine);
}

/// The index of a vector component: 0, 1 or 2 (or -3, -2 or -1, from the end).
fn component(i: INT) -> RhaiResult<usize> {
    match i {
        0..=2 => Ok(i as usize),
        -3..=-1 => Ok((i + 3) as usize),
        _ => Err(invalid(format!("a vec3 has components 0 to 2 (or -3 to -1), not {i}"))),
    }
}

fn register_vec3(engine: &mut Engine) {
    engine
        .register_type_with_name::<DVec3>("Vec3")
        .register_fn("vec3", |x: Dynamic, y: Dynamic, z: Dynamic| -> RhaiResult<DVec3> {
            Ok(DVec3::new(number(&x, "x")?, number(&y, "y")?, number(&z, "z")?))
        })
        .register_fn("vec3", |x: Dynamic, y: Dynamic| -> RhaiResult<DVec3> {
            Ok(DVec3::new(number(&x, "x")?, number(&y, "y")?, 0.0))
        })
        .register_fn("vec3", |v: Dynamic| direction(&v, "vector"))
        .register_get("x", |v: &mut DVec3| v.x)
        .register_get("y", |v: &mut DVec3| v.y)
        .register_get("z", |v: &mut DVec3| v.z)
        .register_set("x", |v: &mut DVec3, x: Dynamic| -> RhaiResult<()> {
            v.x = number(&x, "x")?;
            Ok(())
        })
        .register_set("y", |v: &mut DVec3, y: Dynamic| -> RhaiResult<()> {
            v.y = number(&y, "y")?;
            Ok(())
        })
        .register_set("z", |v: &mut DVec3, z: Dynamic| -> RhaiResult<()> {
            v.z = number(&z, "z")?;
            Ok(())
        })
        // Like the [x, y, z] arrays scripts also use for vectors.
        .register_indexer_get(|v: &mut DVec3, i: INT| -> RhaiResult<FLOAT> {
            Ok(v[component(i)?])
        })
        .register_indexer_set(|v: &mut DVec3, i: INT, value: Dynamic| -> RhaiResult<()> {
            v[component(i)?] = number(&value, "vector component")?;
            Ok(())
        })
        .register_fn("+", |a: DVec3, b: DVec3| a + b)
        .register_fn("-", |a: DVec3, b: DVec3| a - b)
        .register_fn("-", |a: DVec3| -a)
        .register_fn("*", |a: DVec3, s: FLOAT| a * s)
        .register_fn("*", |a: DVec3, s: INT| a * s as f64)
        .register_fn("*", |s: FLOAT, a: DVec3| a * s)
        .register_fn("*", |s: INT, a: DVec3| a * s as f64)
        .register_fn("/", |a: DVec3, s: Dynamic| -> RhaiResult<DVec3> {
            let s = number(&s, "divisor")?;
            if s == 0.0 {
                return Err(invalid("division of a vector by zero"));
            }
            Ok(a / s)
        })
        .register_fn("==", |a: DVec3, b: DVec3| a == b)
        .register_fn("!=", |a: DVec3, b: DVec3| a != b)
        .register_fn("dot", |a: &mut DVec3, b: DVec3| a.dot(b))
        .register_fn("cross", |a: &mut DVec3, b: DVec3| a.cross(b))
        .register_fn("length", |a: &mut DVec3| a.length())
        .register_fn("distance", |a: &mut DVec3, b: DVec3| a.distance(b))
        .register_fn("normalize", |a: &mut DVec3| -> RhaiResult<DVec3> {
            Ok(crate::math::normalize(*a)?)
        })
        .register_fn("to_array", |a: &mut DVec3| -> Array {
            vec![Dynamic::from(a.x), Dynamic::from(a.y), Dynamic::from(a.z)]
        })
        .register_fn("to_string", |a: &mut DVec3| format!("vec3({}, {}, {})", a.x, a.y, a.z))
        .register_fn("to_debug", |a: &mut DVec3| format!("vec3({}, {}, {})", a.x, a.y, a.z));
}

fn register_plane(engine: &mut Engine) {
    engine
        .register_type_with_name::<Plane>("Plane")
        .register_fn("plane", |name: &str| -> RhaiResult<Plane> { Ok(Plane::named(name)?) })
        .register_fn("plane", |origin: Dynamic, normal: Dynamic| -> RhaiResult<Plane> {
            Ok(Plane::new(vector(&origin, "origin")?, direction(&normal, "normal")?)?)
        })
        .register_fn(
            "plane",
            |origin: Dynamic, normal: Dynamic, x_dir: Dynamic| -> RhaiResult<Plane> {
                Ok(Plane::with_x_dir(
                    vector(&origin, "origin")?,
                    direction(&normal, "normal")?,
                    direction(&x_dir, "x direction")?,
                )?)
            },
        )
        .register_get("origin", |p: &mut Plane| p.origin())
        .register_get("normal", |p: &mut Plane| p.normal())
        .register_get("x_dir", |p: &mut Plane| p.x_dir())
        .register_get("y_dir", |p: &mut Plane| p.y_dir())
        .register_fn("offset", |p: &mut Plane, d: Dynamic| -> RhaiResult<Plane> {
            Ok(p.offset(number(&d, "offset")?))
        })
        .register_fn("translate", |p: &mut Plane, v: Dynamic| -> RhaiResult<Plane> {
            Ok(p.translated(vector(&v, "translation")?))
        })
        .register_fn("to_world", |p: &mut Plane, x: Dynamic, y: Dynamic| -> RhaiResult<DVec3> {
            Ok(p.to_world(DVec2::new(number(&x, "x")?, number(&y, "y")?)))
        })
        .register_fn("to_local", |p: &mut Plane, v: Dynamic| -> RhaiResult<DVec3> {
            Ok(p.to_local(vector(&v, "point")?).extend(0.0))
        })
        .register_fn("to_string", |p: &mut Plane| p.to_string())
        .register_fn("to_debug", |p: &mut Plane| p.to_string());
}

fn register_constructors(engine: &mut Engine) {
    engine
        .register_type_with_name::<Shape>("Shape")
        // Solids
        .register_fn("box", |x: Dynamic, y: Dynamic, z: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::make_box(
                number(&x, "x size")?,
                number(&y, "y size")?,
                number(&z, "z size")?,
            )?)
        })
        .register_fn("box_centered", |x: Dynamic, y: Dynamic, z: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::box_centered(
                number(&x, "x size")?,
                number(&y, "y size")?,
                number(&z, "z size")?,
            )?)
        })
        .register_fn("box_from_corners", |a: Dynamic, b: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::box_from_corners(vector(&a, "corner")?, vector(&b, "corner")?)?)
        })
        .register_fn("cube", |size: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::cube(number(&size, "cube size")?)?)
        })
        .register_fn("cylinder", |r: Dynamic, h: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::cylinder(number(&r, "radius")?, number(&h, "height")?)?)
        })
        .register_fn(
            "cylinder",
            |base: Dynamic, axis: Dynamic, r: Dynamic, h: Dynamic| -> RhaiResult<Shape> {
                Ok(Shape::cylinder_at(
                    vector(&base, "base")?,
                    direction(&axis, "axis")?,
                    number(&r, "radius")?,
                    number(&h, "height")?,
                )?)
            },
        )
        .register_fn("sphere", |r: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::sphere(number(&r, "radius")?)?)
        })
        .register_fn("sphere", |center: Dynamic, r: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::sphere_at(vector(&center, "center")?, number(&r, "radius")?)?)
        })
        .register_fn("cone", |r1: Dynamic, r2: Dynamic, h: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::cone(
                number(&r1, "bottom radius")?,
                number(&r2, "top radius")?,
                number(&h, "height")?,
            )?)
        })
        .register_fn("torus", |r1: Dynamic, r2: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::torus(number(&r1, "major radius")?, number(&r2, "minor radius")?)?)
        })
        // Points, curves and wires
        .register_fn("vertex", |p: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::vertex_at(vector(&p, "position")?)?)
        })
        .register_fn("line", |a: Dynamic, b: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::line(vector(&a, "start")?, vector(&b, "end")?)?)
        })
        .register_fn("arc", |a: Dynamic, m: Dynamic, b: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::arc(vector(&a, "start")?, vector(&m, "middle")?, vector(&b, "end")?)?)
        })
        .register_fn("circle", |r: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::circle_on(&Plane::xy(), number(&r, "radius")?)?)
        })
        .register_fn("circle", |p: Dynamic, r: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::circle_on(&plane(&p)?, number(&r, "radius")?)?)
        })
        .register_fn("circle", |c: Dynamic, n: Dynamic, r: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::circle(
                vector(&c, "center")?,
                direction(&n, "normal")?,
                number(&r, "radius")?,
            )?)
        })
        .register_fn("rect", |w: Dynamic, h: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::rect_on(&Plane::xy(), number(&w, "width")?, number(&h, "height")?)?)
        })
        .register_fn("rect", |p: Dynamic, w: Dynamic, h: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::rect_on(&plane(&p)?, number(&w, "width")?, number(&h, "height")?)?)
        })
        .register_fn("polygon", |pts: Array| -> RhaiResult<Shape> {
            Ok(Shape::polygon(&points(&pts, "polygon point")?)?)
        })
        .register_fn("polygon", |p: Dynamic, pts: Array| -> RhaiResult<Shape> {
            Ok(Shape::polygon_on(&plane(&p)?, &points_2d(&pts, "polygon point")?)?)
        })
        .register_fn("polyline", |pts: Array| -> RhaiResult<Shape> {
            Ok(Shape::polyline(&points(&pts, "polyline point")?)?)
        })
        .register_fn("spline", |pts: Array| -> RhaiResult<Shape> {
            Ok(Shape::spline(&points(&pts, "spline point")?, false)?)
        })
        .register_fn("spline", |pts: Array, closed: bool| -> RhaiResult<Shape> {
            Ok(Shape::spline(&points(&pts, "spline point")?, closed)?)
        })
        .register_fn("bezier", |pts: Array| -> RhaiResult<Shape> {
            Ok(Shape::bezier(&points(&pts, "control point")?)?)
        })
        .register_fn("wire", |parts: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::wire_from(&shapes(&parts)?)?)
        })
        .register_fn("face", |boundary: Shape| -> RhaiResult<Shape> {
            Ok(Shape::face_from(&boundary)?)
        })
        .register_fn("face", |outer: Shape, holes: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::face_with_holes(&outer, &shapes(&holes)?)?)
        })
        .register_fn("compound", |parts: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::compound(&shapes(&parts)?)?)
        })
        .register_fn("fuse_all", |parts: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::fuse_all(&shapes(&parts)?)?)
        })
        .register_fn("loft", |sections: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::loft(&shapes(&sections)?, true)?)
        })
        .register_fn("loft", |sections: Dynamic, solid: bool| -> RhaiResult<Shape> {
            Ok(Shape::loft(&shapes(&sections)?, solid)?)
        })
        .register_fn("ruled_loft", |sections: Dynamic| -> RhaiResult<Shape> {
            Ok(Shape::ruled_loft(&shapes(&sections)?, true)?)
        })
        .register_fn("ruled_loft", |sections: Dynamic, solid: bool| -> RhaiResult<Shape> {
            Ok(Shape::ruled_loft(&shapes(&sections)?, solid)?)
        });
}

fn register_shape(engine: &mut Engine) {
    engine
        // Identity and type
        .register_fn("shape_type", |s: &mut Shape| s.shape_type().name().to_string())
        .register_fn("is_valid", |s: &mut Shape| s.is_valid())
        .register_fn("is_closed", |s: &mut Shape| s.is_closed())
        .register_fn("is_same", |s: &mut Shape, other: Shape| s.is_same(&other))
        .register_fn("==", |a: &mut Shape, b: Shape| a.is_same(&b))
        .register_fn("!=", |a: &mut Shape, b: Shape| !a.is_same(&b))
        .register_fn("to_string", |s: &mut Shape| s.to_string())
        .register_fn("to_debug", |s: &mut Shape| s.to_string())
        // Measurements
        .register_fn("volume", |s: &mut Shape| -> RhaiResult<FLOAT> { Ok(s.volume()?) })
        .register_fn("area", |s: &mut Shape| -> RhaiResult<FLOAT> { Ok(s.area()?) })
        .register_fn("length", |s: &mut Shape| -> RhaiResult<FLOAT> { Ok(s.length()?) })
        .register_fn("center", |s: &mut Shape| -> RhaiResult<DVec3> { Ok(s.center()?) })
        .register_fn("bounding_box", |s: &mut Shape| -> RhaiResult<BoundingBox> {
            Ok(s.bounding_box()?)
        })
        .register_fn("distance", |s: &mut Shape, other: Shape| -> RhaiResult<FLOAT> {
            Ok(s.distance(&other)?)
        })
        .register_fn("closest_points", |s: &mut Shape, other: Shape| -> RhaiResult<Array> {
            let (a, b) = s.closest_points(&other)?;
            Ok(vec_array(&[a, b]))
        })
        .register_fn("contains", |s: &mut Shape, p: Dynamic| -> RhaiResult<bool> {
            Ok(s.contains(vector(&p, "point")?)?)
        })
        .register_fn("classify", |s: &mut Shape, p: Dynamic| -> RhaiResult<String> {
            Ok(s.classify(vector(&p, "point")?)?.name().to_string())
        })
        // Booleans
        .register_fn("fuse", |a: &mut Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.fuse(&b)?) })
        .register_fn("union", |a: &mut Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.fuse(&b)?) })
        .register_fn("cut", |a: &mut Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.cut(&b)?) })
        .register_fn("common", |a: &mut Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.common(&b)?) })
        .register_fn("intersect", |a: &mut Shape, b: Shape| -> RhaiResult<Shape> {
            Ok(a.common(&b)?)
        })
        .register_fn("section", |a: &mut Shape, b: Shape| -> RhaiResult<Shape> {
            Ok(a.section(&b)?)
        })
        .register_fn("+", |a: Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.fuse(&b)?) })
        .register_fn("-", |a: Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.cut(&b)?) })
        .register_fn("&", |a: Shape, b: Shape| -> RhaiResult<Shape> { Ok(a.common(&b)?) })
        // Transforms
        .register_fn("translate", |s: &mut Shape, v: Dynamic| -> RhaiResult<Shape> {
            Ok(s.translate(vector(&v, "translation")?)?)
        })
        .register_fn(
            "translate",
            |s: &mut Shape, x: Dynamic, y: Dynamic, z: Dynamic| -> RhaiResult<Shape> {
                Ok(s.translate(DVec3::new(number(&x, "x")?, number(&y, "y")?, number(&z, "z")?))?)
            },
        )
        .register_fn("rotate", |s: &mut Shape, axis: Dynamic, deg: Dynamic| -> RhaiResult<Shape> {
            Ok(s.rotate(DVec3::ZERO, direction(&axis, "axis")?, number(&deg, "angle")?)?)
        })
        .register_fn(
            "rotate",
            |s: &mut Shape, origin: Dynamic, axis: Dynamic, deg: Dynamic| -> RhaiResult<Shape> {
                Ok(s.rotate(
                    vector(&origin, "origin")?,
                    direction(&axis, "axis")?,
                    number(&deg, "angle")?,
                )?)
            },
        )
        .register_fn("rotate_x", |s: &mut Shape, deg: Dynamic| -> RhaiResult<Shape> {
            Ok(s.rotate(DVec3::ZERO, DVec3::X, number(&deg, "angle")?)?)
        })
        .register_fn("rotate_y", |s: &mut Shape, deg: Dynamic| -> RhaiResult<Shape> {
            Ok(s.rotate(DVec3::ZERO, DVec3::Y, number(&deg, "angle")?)?)
        })
        .register_fn("rotate_z", |s: &mut Shape, deg: Dynamic| -> RhaiResult<Shape> {
            Ok(s.rotate(DVec3::ZERO, DVec3::Z, number(&deg, "angle")?)?)
        })
        .register_fn("scale", |s: &mut Shape, f: Dynamic| -> RhaiResult<Shape> {
            Ok(s.scale(DVec3::ZERO, number(&f, "scale factor")?)?)
        })
        .register_fn("scale", |s: &mut Shape, c: Dynamic, f: Dynamic| -> RhaiResult<Shape> {
            Ok(s.scale(vector(&c, "center")?, number(&f, "scale factor")?)?)
        })
        .register_fn("mirror", |s: &mut Shape, p: Dynamic| -> RhaiResult<Shape> {
            // A plane (or plane name) mirrors through that plane; a direction (including axis
            // names like "-Z") mirrors through the plane through the origin with that normal.
            let named = p.clone().into_string().ok().and_then(|n| Plane::named(&n).ok());
            if let Some(pl) = p.clone().try_cast::<Plane>().or(named) {
                Ok(s.mirror(pl.origin(), pl.normal())?)
            } else {
                Ok(s.mirror(DVec3::ZERO, direction(&p, "mirror normal")?)?)
            }
        })
        .register_fn("mirror", |s: &mut Shape, o: Dynamic, n: Dynamic| -> RhaiResult<Shape> {
            Ok(s.mirror(vector(&o, "origin")?, direction(&n, "normal")?)?)
        })
        // Features
        .register_fn("extrude", |s: &mut Shape, v: Dynamic| -> RhaiResult<Shape> {
            if v.is_int() || v.is_float() {
                Ok(s.extrude_normal(number(&v, "distance")?)?)
            } else {
                Ok(s.extrude(direction(&v, "extrusion")?)?)
            }
        })
        .register_fn("revolve", |s: &mut Shape, axis: Dynamic, deg: Dynamic| -> RhaiResult<Shape> {
            Ok(s.revolve(DVec3::ZERO, direction(&axis, "axis")?, number(&deg, "angle")?)?)
        })
        .register_fn(
            "revolve",
            |s: &mut Shape, origin: Dynamic, axis: Dynamic, deg: Dynamic| -> RhaiResult<Shape> {
                Ok(s.revolve(
                    vector(&origin, "origin")?,
                    direction(&axis, "axis")?,
                    number(&deg, "angle")?,
                )?)
            },
        )
        .register_fn("sweep", |s: &mut Shape, path: Shape| -> RhaiResult<Shape> {
            Ok(s.sweep(&path)?)
        })
        .register_fn("fillet", |s: &mut Shape, r: Dynamic| -> RhaiResult<Shape> {
            Ok(s.fillet_all(number(&r, "fillet radius")?)?)
        })
        .register_fn("fillet", |s: &mut Shape, r: Dynamic, edges: Dynamic| -> RhaiResult<Shape> {
            let edges = pick(s, ShapeType::Edge, &edges)?;
            Ok(s.fillet(number(&r, "fillet radius")?, &edges)?)
        })
        .register_fn("chamfer", |s: &mut Shape, d: Dynamic| -> RhaiResult<Shape> {
            Ok(s.chamfer_all(number(&d, "chamfer distance")?)?)
        })
        .register_fn("chamfer", |s: &mut Shape, d: Dynamic, edges: Dynamic| -> RhaiResult<Shape> {
            let edges = pick(s, ShapeType::Edge, &edges)?;
            Ok(s.chamfer(number(&d, "chamfer distance")?, &edges)?)
        })
        .register_fn("shell", |s: &mut Shape, t: Dynamic| -> RhaiResult<Shape> {
            Ok(s.shell(number(&t, "thickness")?, &[])?)
        })
        .register_fn("shell", |s: &mut Shape, t: Dynamic, faces: Dynamic| -> RhaiResult<Shape> {
            let faces = pick(s, ShapeType::Face, &faces)?;
            Ok(s.shell(number(&t, "thickness")?, &faces)?)
        })
        .register_fn("offset", |s: &mut Shape, d: Dynamic| -> RhaiResult<Shape> {
            Ok(s.offset_2d(number(&d, "offset")?)?)
        })
        .register_fn("clean", |s: &mut Shape| -> RhaiResult<Shape> { Ok(s.clean()?) })
        .register_fn("to_face", |s: &mut Shape| -> RhaiResult<Shape> { Ok(Shape::face_from(s)?) })
        // Exploration
        .register_fn("faces", |s: &mut Shape| s.faces())
        .register_fn("edges", |s: &mut Shape| s.edges())
        .register_fn("vertices", |s: &mut Shape| s.vertices())
        .register_fn("wires", |s: &mut Shape| s.wires())
        .register_fn("shells", |s: &mut Shape| s.shells())
        .register_fn("solids", |s: &mut Shape| s.solids())
        .register_fn("faces", |s: &mut Shape, sel: &str| -> RhaiResult<Selection> {
            Ok(s.faces().select(sel)?)
        })
        .register_fn("edges", |s: &mut Shape, sel: &str| -> RhaiResult<Selection> {
            Ok(s.edges().select(sel)?)
        })
        .register_fn("vertices", |s: &mut Shape, sel: &str| -> RhaiResult<Selection> {
            Ok(s.vertices().select(sel)?)
        })
        .register_fn("face", |s: &mut Shape, sel: &str| -> RhaiResult<Shape> {
            Ok(s.faces().select(sel)?.first()?)
        })
        .register_fn("edge", |s: &mut Shape, sel: &str| -> RhaiResult<Shape> {
            Ok(s.edges().select(sel)?.first()?)
        })
        .register_fn("vertex", |s: &mut Shape, sel: &str| -> RhaiResult<Shape> {
            Ok(s.vertices().select(sel)?.first()?)
        })
        .register_fn("top_face", |s: &mut Shape| -> RhaiResult<Shape> {
            Ok(s.faces().farthest(DVec3::Z)?.first()?)
        })
        .register_fn("bottom_face", |s: &mut Shape| -> RhaiResult<Shape> {
            Ok(s.faces().nearest(DVec3::Z)?.first()?)
        })
        .register_fn("children", |s: &mut Shape| s.children() as INT)
        // Edge, face and vertex queries
        .register_fn("point", |s: &mut Shape| -> RhaiResult<DVec3> { Ok(s.point()?) })
        .register_fn("start_point", |s: &mut Shape| -> RhaiResult<DVec3> { Ok(s.start_point()?) })
        .register_fn("end_point", |s: &mut Shape| -> RhaiResult<DVec3> { Ok(s.end_point()?) })
        .register_fn("point_at", |s: &mut Shape, t: Dynamic| -> RhaiResult<DVec3> {
            Ok(s.point_at(number(&t, "parameter")?)?)
        })
        .register_fn("tangent_at", |s: &mut Shape, t: Dynamic| -> RhaiResult<DVec3> {
            Ok(s.tangent_at(number(&t, "parameter")?)?)
        })
        .register_fn("radius", |s: &mut Shape| -> RhaiResult<FLOAT> { Ok(s.radius()?) })
        .register_fn("geom_type", |s: &mut Shape| -> RhaiResult<String> {
            Ok(s.geom_type()?.to_string())
        })
        .register_fn("normal", |s: &mut Shape| -> RhaiResult<DVec3> { Ok(s.normal()?) })
        .register_fn("plane", |s: &mut Shape| -> RhaiResult<Plane> { Ok(s.plane()?) })
        .register_fn("outer_wire", |s: &mut Shape| -> RhaiResult<Shape> { Ok(s.outer_wire()?) })
        // Meshing
        .register_fn("mesh", |s: &mut Shape, tolerance: Dynamic| -> RhaiResult<Mesh> {
            Ok(s.mesh(number(&tolerance, "tolerance")?)?)
        })
        .register_fn(
            "mesh",
            |s: &mut Shape, tolerance: Dynamic, degrees: Dynamic| -> RhaiResult<Mesh> {
                let options = MeshOptions::new(number(&tolerance, "tolerance")?)
                    .angular_tolerance(number(&degrees, "angular tolerance")?);
                Ok(s.mesh_with(&options)?)
            },
        );
}

fn call_predicate(ctx: &NativeCallContext, f: &FnPtr, shape: &Shape) -> RhaiResult<bool> {
    let result: Dynamic = f.call_within_context(ctx, (shape.clone(),))?;
    result
        .as_bool()
        .map_err(|actual| invalid(format!("filter function must return a bool, got {actual}")))
}

fn register_selection(engine: &mut Engine) {
    engine
        .register_type_with_name::<Selection>("Selection")
        .register_iterator::<Selection>()
        .register_fn("selection", |items: Dynamic| -> RhaiResult<Selection> {
            Ok(Selection::new(shapes(&items)?))
        })
        .register_fn("len", |s: &mut Selection| s.len() as INT)
        .register_fn("is_empty", |s: &mut Selection| s.is_empty())
        .register_indexer_get(|s: &mut Selection, i: INT| -> RhaiResult<Shape> { Ok(s.get(i)?) })
        .register_fn("get", |s: &mut Selection, i: INT| -> RhaiResult<Shape> { Ok(s.get(i)?) })
        .register_fn("first", |s: &mut Selection| -> RhaiResult<Shape> { Ok(s.first()?) })
        .register_fn("last", |s: &mut Selection| -> RhaiResult<Shape> { Ok(s.last()?) })
        .register_fn("single", |s: &mut Selection| -> RhaiResult<Shape> { Ok(s.single()?) })
        .register_fn("select", |s: &mut Selection, sel: &str| -> RhaiResult<Selection> {
            Ok(s.select(sel)?)
        })
        .register_fn(
            "filter",
            |ctx: NativeCallContext, s: &mut Selection, f: FnPtr| -> RhaiResult<Selection> {
                let mut kept = Vec::new();
                for shape in s.iter() {
                    if call_predicate(&ctx, &f, shape)? {
                        kept.push(shape.clone());
                    }
                }
                Ok(Selection::new(kept))
            },
        )
        .register_fn(
            "sort_by",
            |ctx: NativeCallContext, s: &mut Selection, f: FnPtr| -> RhaiResult<Selection> {
                let mut keyed = Vec::with_capacity(s.len());
                for shape in s.iter() {
                    let key: Dynamic = f.call_within_context(&ctx, (shape.clone(),))?;
                    keyed.push((number(&key, "sort key")?, shape.clone()));
                }
                keyed.sort_by(|a, b| a.0.total_cmp(&b.0));
                Ok(keyed.into_iter().map(|(_, shape)| shape).collect())
            },
        )
        .register_fn("farthest", |s: &mut Selection, d: Dynamic| -> RhaiResult<Selection> {
            Ok(s.farthest(direction(&d, "direction")?)?)
        })
        .register_fn("nearest", |s: &mut Selection, d: Dynamic| -> RhaiResult<Selection> {
            Ok(s.nearest(direction(&d, "direction")?)?)
        })
        .register_fn("top", |s: &mut Selection| -> RhaiResult<Selection> {
            Ok(s.farthest(DVec3::Z)?)
        })
        .register_fn("bottom", |s: &mut Selection| -> RhaiResult<Selection> {
            Ok(s.nearest(DVec3::Z)?)
        })
        .register_fn("right", |s: &mut Selection| -> RhaiResult<Selection> {
            Ok(s.farthest(DVec3::X)?)
        })
        .register_fn("left", |s: &mut Selection| -> RhaiResult<Selection> {
            Ok(s.nearest(DVec3::X)?)
        })
        .register_fn("back", |s: &mut Selection| -> RhaiResult<Selection> {
            Ok(s.farthest(DVec3::Y)?)
        })
        .register_fn("front", |s: &mut Selection| -> RhaiResult<Selection> {
            Ok(s.nearest(DVec3::Y)?)
        })
        .register_fn("parallel_to", |s: &mut Selection, d: Dynamic| -> RhaiResult<Selection> {
            Ok(s.parallel_to(direction(&d, "direction")?)?)
        })
        .register_fn("perpendicular_to", |s: &mut Selection, d: Dynamic| -> RhaiResult<Selection> {
            Ok(s.perpendicular_to(direction(&d, "direction")?)?)
        })
        .register_fn("facing", |s: &mut Selection, d: Dynamic| -> RhaiResult<Selection> {
            Ok(s.facing(direction(&d, "direction")?)?)
        })
        .register_fn("of_type", |s: &mut Selection, t: &str| -> RhaiResult<Selection> {
            Ok(s.of_type(t)?)
        })
        .register_fn("union", |a: &mut Selection, b: Selection| a.union(&b))
        .register_fn("intersect", |a: &mut Selection, b: Selection| a.intersect(&b))
        .register_fn("subtract", |a: &mut Selection, b: Selection| a.subtract(&b))
        .register_fn("+", |a: Selection, b: Selection| a.union(&b))
        .register_fn("-", |a: Selection, b: Selection| a.subtract(&b))
        .register_fn("to_array", |s: &mut Selection| shape_array(s))
        .register_fn("compound", |s: &mut Selection| -> RhaiResult<Shape> { Ok(s.to_compound()?) })
        .register_fn("to_string", |s: &mut Selection| s.to_string())
        .register_fn("to_debug", |s: &mut Selection| s.to_string());
}

fn register_sketch(engine: &mut Engine) {
    type SketchFn2 = fn(&Sketch, f64, f64) -> CrateResult<Sketch>;
    type SketchFn1 = fn(&Sketch, f64) -> CrateResult<Sketch>;

    engine
        .register_type_with_name::<Sketch>("Sketch")
        .register_fn("sketch", || Sketch::new(Plane::xy()))
        .register_fn("sketch", |p: Dynamic| -> RhaiResult<Sketch> { Ok(Sketch::new(plane(&p)?)) })
        .register_fn(
            "arc_to",
            |s: &mut Sketch,
             mx: Dynamic,
             my: Dynamic,
             x: Dynamic,
             y: Dynamic|
             -> RhaiResult<Sketch> {
                Ok(s.arc_to(
                    number(&mx, "x")?,
                    number(&my, "y")?,
                    number(&x, "x")?,
                    number(&y, "y")?,
                )?)
            },
        )
        .register_fn("close", |s: &mut Sketch| -> RhaiResult<Shape> { Ok(s.close()?) })
        .register_fn("wire", |s: &mut Sketch| -> RhaiResult<Shape> { Ok(s.wire()?) })
        .register_fn("face", |s: &mut Sketch| -> RhaiResult<Shape> { Ok(s.face()?) })
        .register_fn("position", |s: &mut Sketch| s.position().extend(0.0))
        .register_fn("plane", |s: &mut Sketch| s.plane())
        .register_fn("segment_count", |s: &mut Sketch| s.segment_count() as INT)
        .register_fn("to_string", |s: &mut Sketch| s.to_string())
        .register_fn("to_debug", |s: &mut Sketch| s.to_string());

    let two_arg: [(&str, SketchFn2); 4] = [
        ("move_to", Sketch::move_to),
        ("line_to", Sketch::line_to),
        ("line", Sketch::line),
        ("polar_line", Sketch::polar_line),
    ];
    for (name, f) in two_arg {
        engine.register_fn(
            name,
            move |s: &mut Sketch, a: Dynamic, b: Dynamic| -> RhaiResult<Sketch> {
                Ok(f(s, number(&a, "first argument")?, number(&b, "second argument")?)?)
            },
        );
    }
    let one_arg: [(&str, SketchFn1); 4] = [
        ("hline", Sketch::hline),
        ("vline", Sketch::vline),
        ("hline_to", Sketch::hline_to),
        ("vline_to", Sketch::vline_to),
    ];
    for (name, f) in one_arg {
        engine.register_fn(name, move |s: &mut Sketch, a: Dynamic| -> RhaiResult<Sketch> {
            Ok(f(s, number(&a, "argument")?)?)
        });
    }
}

fn register_results(engine: &mut Engine) {
    // Errors carry their `ErrorKind` as their tag (see `error_kind`), so scripts may read tags but
    // not set them: a script cannot pass off a value it throws as one of this crate's errors.
    // These take precedence over the setters in Rhai's standard package.
    let read_only = |_: &mut Dynamic, _: INT| -> RhaiResult<()> {
        Err(invalid("tags are read-only: they carry the kind of an error"))
    };
    engine.register_fn("set_tag", read_only).register_set("tag", read_only);
    engine
        .register_type_with_name::<BoundingBox>("BoundingBox")
        .register_get("min", |b: &mut BoundingBox| b.min)
        .register_get("max", |b: &mut BoundingBox| b.max)
        .register_get("center", |b: &mut BoundingBox| b.center())
        .register_get("size", |b: &mut BoundingBox| b.size())
        .register_get("xlen", |b: &mut BoundingBox| b.size().x)
        .register_get("ylen", |b: &mut BoundingBox| b.size().y)
        .register_get("zlen", |b: &mut BoundingBox| b.size().z)
        .register_fn("contains", |b: &mut BoundingBox, p: Dynamic| -> RhaiResult<bool> {
            Ok(b.contains(vector(&p, "point")?))
        })
        .register_fn("to_string", |b: &mut BoundingBox| b.to_string())
        .register_fn("to_debug", |b: &mut BoundingBox| b.to_string())
        .register_type_with_name::<Mesh>("Mesh")
        .register_get("vertices", |m: &mut Mesh| vec_array(&m.vertices))
        .register_get("normals", |m: &mut Mesh| vec_array(&m.normals))
        .register_get("indices", |m: &mut Mesh| -> Array {
            m.indices.iter().map(|&i| Dynamic::from(i as INT)).collect()
        })
        .register_get("vertex_count", |m: &mut Mesh| m.vertex_count() as INT)
        .register_get("triangle_count", |m: &mut Mesh| m.triangle_count() as INT)
        .register_fn("area", |m: &mut Mesh| m.area())
        .register_fn("welded", |m: &mut Mesh| m.welded())
        .register_fn("to_string", |m: &mut Mesh| m.to_string())
        .register_fn("to_debug", |m: &mut Mesh| m.to_string());
}
