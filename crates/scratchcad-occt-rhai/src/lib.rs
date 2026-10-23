//! Script the [OpenCASCADE](https://dev.opencascade.org) CAD kernel with [Rhai](https://rhai.rs).
//!
//! The crate has two layers:
//!
//! * A Rust API built around cheap-to-clone, immutable handle types ([`Shape`], [`Selection`],
//!   [`Sketch`], [`Plane`]) whose operations all return [`Result`] and chain naturally.
//! * [`register`], which exposes that API to a Rhai [`Engine`] with
//!   script-friendly argument conversions. Scripts model, measure and mesh; they cannot read or
//!   write files.
//!
//! Files are the host's job: shapes convert to and from STEP, IGES, BREP and (write-only) STL in
//! memory ([`Shape::to_bytes`], [`Shape::from_bytes`]; IGES is read only from files) or as files
//! ([`Shape::export`], [`Shape::import`]). Long-running OpenCASCADE algorithms
//! can be stopped from another thread with a [`CancelToken`] (see [`with_cancel`]), and
//! OpenCASCADE's console output can be redirected with [`set_message_handler`].
//!
//! ```no_run
//! let part = scratchcad_occt_rhai::eval_shape(r#"
//!     let plate = box(40, 30, 5).fillet(2, "|Z");
//!     let hole = cylinder(4, 5).translate([20, 15, 0]);
//!     (plate - hole).chamfer(0.5, ">Z")
//! "#)?;
//! part.write_step("plate.step")?;
//! # Ok::<(), Box<dyn std::error::Error>>(())
//! ```
//!
//! A script works on a shape the host read from a file when the host passes it in:
//!
//! ```no_run
//! use scratchcad_occt_rhai::{engine, rhai::Scope, Shape};
//!
//! let mut scope = Scope::new();
//! scope.push("part", Shape::read_step("bracket.step")?);
//! let drilled: Shape = engine().eval_with_scope(&mut scope, "part - cylinder(3, 50)")?;
//! drilled.write_step("drilled.step")?;
//! # Ok::<(), Box<dyn std::error::Error>>(())
//! ```
//!
//! The same model through the Rust API:
//!
//! ```no_run
//! use scratchcad_occt_rhai::{DVec3, Shape};
//!
//! fn main() -> Result<(), scratchcad_occt_rhai::Error> {
//!     let plate = Shape::make_box(40.0, 30.0, 5.0)?;
//!     let vertical_edges = plate.edges().select("|Z")?;
//!     let hole = Shape::cylinder(4.0, 5.0)?.translate(DVec3::new(20.0, 15.0, 0.0))?;
//!     let part = plate.fillet(2.0, vertical_edges.shapes())?.cut(&hole)?;
//!     part.write_step("plate.step")
//! }
//! ```

pub mod cancel;
mod error;
mod io;
mod loft;
pub mod math;
mod mesh;
pub mod messages;
pub mod script;
mod selection;
pub mod selector;
mod shape;
mod sketch;

pub use cancel::{with_cancel, CancelToken};
pub use error::{error_kind, Error, ErrorKind, Result};
pub use glam::{DVec2, DVec3};
pub use io::Format;
pub use math::Plane;
pub use mesh::{Mesh, MeshOptions};
pub use messages::{set_message_handler, set_occt_messages, MessageLevel};
pub use rhai;
pub use scratchcad_occt_sys as ffi;
pub use script::{register, to_shape};
pub use selection::{Selection, TOLERANCE};
pub use shape::{
    BoundingBox, DetachedShape, MassProperties, PointLocation, Shape, ShapeType, CLASSIFY_TOLERANCE,
};
pub use sketch::Sketch;

use rhai::{Dynamic, Engine, EvalAltResult};

/// A Rhai engine with every type and function of this crate registered (see [`register`]).
/// Scripts run on it cannot touch the filesystem; set Rhai's own limits (such as
/// `Engine::set_max_operations`) before running scripts you do not trust.
pub fn engine() -> Engine {
    let mut engine = Engine::new();
    register(&mut engine);
    engine
}

/// Evaluates a script and returns its result.
pub fn eval(script: &str) -> std::result::Result<Dynamic, Box<EvalAltResult>> {
    engine().eval::<Dynamic>(script)
}

/// Evaluates a script that produces a shape (or a selection, array of shapes or sketch, which
/// are converted with [`to_shape`]).
pub fn eval_shape(script: &str) -> std::result::Result<Shape, Box<EvalAltResult>> {
    to_shape(eval(script)?)
}
