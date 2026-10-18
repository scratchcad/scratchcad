//! Reading and writing STEP, IGES, BREP and STL, in memory or as files.
//!
//! OpenCASCADE's STEP and IGES translators keep global state, so those conversions are
//! serialized through a process-wide lock. BREP and STL conversions run concurrently.

use crate::{
    cancel::{check, failed, progress},
    error::{Error, Result},
    mesh::MeshOptions,
    shape::Shape,
};
use scratchcad_occt_sys as ffi;
use std::{fmt, path::Path, sync::Mutex};

static TRANSLATOR_LOCK: Mutex<()> = Mutex::new(());

/// Runs a STEP or IGES conversion while holding the translator lock.
pub(crate) fn translator<T>(f: impl FnOnce() -> Result<T>) -> Result<T> {
    // A panic while holding the lock cannot leave OCCT in a worse state than the panic itself.
    let _guard = TRANSLATOR_LOCK.lock().unwrap_or_else(|poisoned| poisoned.into_inner());
    f()
}

/// A file format shapes can be written in and (except STL) read from.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum Format {
    /// ISO 10303-21 (AP214), the usual format for exchanging exact CAD geometry.
    Step,
    /// IGES 5.3, an older exact-geometry exchange format.
    Iges,
    /// OpenCASCADE's native text format, which round-trips shapes exactly.
    Brep,
    /// A binary STL triangle mesh, for 3D printing and viewers. Write-only.
    Stl,
}

impl Format {
    pub const ALL: [Format; 4] = [Format::Step, Format::Iges, Format::Brep, Format::Stl];

    /// The format for a file extension (case-insensitive, without the dot): `step`/`stp`,
    /// `iges`/`igs`, `brep`/`brp` or `stl`.
    pub fn from_extension(extension: &str) -> Option<Self> {
        match extension.to_ascii_lowercase().as_str() {
            "step" | "stp" => Some(Format::Step),
            "iges" | "igs" => Some(Format::Iges),
            "brep" | "brp" => Some(Format::Brep),
            "stl" => Some(Format::Stl),
            _ => None,
        }
    }

    /// The format implied by a path's extension.
    pub fn from_path(path: &Path) -> Result<Self> {
        path.extension()
            .and_then(|extension| Self::from_extension(&extension.to_string_lossy()))
            .ok_or_else(|| unsupported(path))
    }

    /// The usual file extension, without the dot.
    pub fn extension(self) -> &'static str {
        match self {
            Format::Step => "step",
            Format::Iges => "iges",
            Format::Brep => "brep",
            Format::Stl => "stl",
        }
    }

    /// The format's name, e.g. `"STEP"`.
    pub fn name(self) -> &'static str {
        match self {
            Format::Step => "STEP",
            Format::Iges => "IGES",
            Format::Brep => "BREP",
            Format::Stl => "STL",
        }
    }

    /// The media (MIME) type for HTTP responses.
    pub fn media_type(self) -> &'static str {
        match self {
            Format::Step => "model/step",
            Format::Iges => "model/iges",
            Format::Brep => "application/octet-stream",
            Format::Stl => "model/stl",
        }
    }

    /// Whether the format stores a triangle mesh rather than exact geometry.
    pub fn is_mesh(self) -> bool {
        self == Format::Stl
    }
}

impl fmt::Display for Format {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.name())
    }
}

fn path_string(path: &Path) -> String {
    path.to_string_lossy().into_owned()
}

fn convert_error(action: &str, format: Format) -> Error {
    match failed("conversion") {
        Error::Cancelled => Error::Cancelled,
        _ => Error::Io(format!("failed to {action} {format}")),
    }
}

fn file_error(action: &str, format: Format, path: &Path, detail: impl fmt::Display) -> Error {
    match failed("conversion") {
        Error::Cancelled => Error::Cancelled,
        _ => Error::Io(format!("failed to {action} {format} file {}: {detail}", path.display())),
    }
}

fn bytes_of(string: cxx::UniquePtr<cxx::CxxString>, format: Format) -> Result<Vec<u8>> {
    match string.as_ref() {
        Some(string) => Ok(string.as_bytes().to_vec()),
        None => Err(convert_error("write", format)),
    }
}

/// The result of a conversion, unless it was cancelled: a translator stopped part way can report
/// success with only part of the model.
fn finished<T>(result: T) -> Result<T> {
    check()?;
    Ok(result)
}

impl Shape {
    // ---------------------------------------------------------------------------------------
    // In memory
    // ---------------------------------------------------------------------------------------

    /// The shape as a STEP file.
    pub fn to_step(&self) -> Result<Vec<u8>> {
        translator(|| {
            let mut writer = ffi::step_control::STEPControl_Writer_new();
            let status = ffi::step_control::transfer_shape_with_progress(
                writer.pin_mut(),
                self.raw(),
                &progress(),
            )?;
            if status != ffi::if_select::IFSelect_ReturnStatus::IFSelect_RetDone {
                return Err(convert_error("convert the shape to", Format::Step));
            }
            let bytes =
                bytes_of(ffi::step_control::write_step_bytes(writer.pin_mut())?, Format::Step)?;
            finished(bytes)
        })
    }

    /// The shape as an IGES file.
    pub fn to_iges(&self) -> Result<Vec<u8>> {
        translator(|| {
            let mut writer = ffi::iges_control::IGESControl_Writer_new();
            if !writer.pin_mut().AddShape(self.raw(), &progress())? {
                return Err(convert_error("convert the shape to", Format::Iges));
            }
            writer.pin_mut().ComputeModel()?;
            let bytes =
                bytes_of(ffi::iges_control::write_iges_bytes(writer.pin_mut())?, Format::Iges)?;
            finished(bytes)
        })
    }

    /// The shape in OpenCASCADE's text BREP format, which round-trips it exactly.
    pub fn to_brep(&self) -> Result<Vec<u8>> {
        let bytes =
            bytes_of(ffi::b_rep_tools::write_brep_bytes(self.raw(), &progress())?, Format::Brep)?;
        finished(bytes)
    }

    /// The shape meshed with `options`, as a binary STL file.
    pub fn to_stl(&self, options: &MeshOptions) -> Result<Vec<u8>> {
        finished(self.mesh_with(options)?.to_stl())
    }

    /// The shape in `format`. `stl` sets how finely STL files are meshed; the other formats
    /// store exact geometry.
    pub fn to_bytes(&self, format: Format, stl: &MeshOptions) -> Result<Vec<u8>> {
        match format {
            Format::Step => self.to_step(),
            Format::Iges => self.to_iges(),
            Format::Brep => self.to_brep(),
            Format::Stl => self.to_stl(stl),
        }
    }

    /// Reads all shapes from a STEP file (as a compound when there are several).
    pub fn from_step(bytes: &[u8]) -> Result<Shape> {
        translator(|| {
            let mut reader = ffi::step_control::STEPControl_Reader_new();
            let status = ffi::step_control::read_step_bytes(reader.pin_mut(), bytes)?;
            if status != ffi::if_select::IFSelect_ReturnStatus::IFSelect_RetDone {
                return Err(convert_error("read", Format::Step));
            }
            reader.pin_mut().TransferRoots(&progress())?;
            let shape = Shape::from_unique(ffi::step_control::one_shape_step(&reader)?)
                .map_err(|_| convert_error("read", Format::Step))?;
            finished(shape)
        })
    }

    /// Reads a shape in OpenCASCADE's text BREP format.
    pub fn from_brep(bytes: &[u8]) -> Result<Shape> {
        let shape = ffi::b_rep_tools::read_brep_bytes(bytes, &progress())?;
        finished(Shape::from_unique(shape).map_err(|_| convert_error("read", Format::Brep))?)
    }

    /// Reads a shape in `format`: STEP or BREP. STL files hold meshes, not shapes, and cannot be
    /// read; OpenCASCADE 7.8 reads IGES only from files, so use [`Shape::read_iges`] for those.
    pub fn from_bytes(format: Format, bytes: &[u8]) -> Result<Shape> {
        match format {
            Format::Step => Shape::from_step(bytes),
            Format::Iges => Err(Error::Io(
                "IGES can only be read from a file, not from memory (use Shape::read_iges)".into(),
            )),
            Format::Brep => Shape::from_brep(bytes),
            Format::Stl => {
                Err(Error::Io("STL files hold meshes and cannot be read as shapes".into()))
            },
        }
    }

    // ---------------------------------------------------------------------------------------
    // Files
    // ---------------------------------------------------------------------------------------

    fn write_file(path: &Path, format: Format, bytes: Result<Vec<u8>>) -> Result<()> {
        std::fs::write(path, bytes?).map_err(|e| file_error("write", format, path, e))
    }

    fn read_file(path: &Path, format: Format) -> Result<Vec<u8>> {
        std::fs::read(path).map_err(|e| file_error("read", format, path, e))
    }

    /// Reads all shapes from a STEP file (as a compound when there are several).
    pub fn read_step(path: impl AsRef<Path>) -> Result<Shape> {
        let path = path.as_ref();
        Shape::from_step(&Self::read_file(path, Format::Step)?)
            .map_err(|e| with_path(e, Format::Step, path))
    }

    pub fn write_step(&self, path: impl AsRef<Path>) -> Result<()> {
        Self::write_file(path.as_ref(), Format::Step, self.to_step())
    }

    /// Reads all shapes from an IGES file (as a compound when there are several).
    pub fn read_iges(path: impl AsRef<Path>) -> Result<Shape> {
        let path = path.as_ref();
        translator(|| {
            let mut reader = ffi::iges_control::IGESControl_Reader_new();
            let status = ffi::iges_control::read_iges(reader.pin_mut(), path_string(path))?;
            if status != ffi::if_select::IFSelect_ReturnStatus::IFSelect_RetDone {
                return Err(file_error("read", Format::Iges, path, "not a readable IGES file"));
            }
            reader.pin_mut().TransferRoots(&progress())?;
            let shape = Shape::from_unique(ffi::iges_control::one_shape_iges(&reader)?)
                .map_err(|_| file_error("read", Format::Iges, path, "it holds no shapes"))?;
            finished(shape)
        })
    }

    pub fn write_iges(&self, path: impl AsRef<Path>) -> Result<()> {
        Self::write_file(path.as_ref(), Format::Iges, self.to_iges())
    }

    /// Reads OpenCASCADE's native text BREP format.
    pub fn read_brep(path: impl AsRef<Path>) -> Result<Shape> {
        let path = path.as_ref();
        Shape::from_brep(&Self::read_file(path, Format::Brep)?)
            .map_err(|e| with_path(e, Format::Brep, path))
    }

    /// Writes OpenCASCADE's native text BREP format, which round-trips shapes exactly.
    pub fn write_brep(&self, path: impl AsRef<Path>) -> Result<()> {
        Self::write_file(path.as_ref(), Format::Brep, self.to_brep())
    }

    /// Meshes the shape with the given tolerance and writes a binary STL file.
    pub fn write_stl(&self, path: impl AsRef<Path>, tolerance: f64) -> Result<()> {
        Self::write_file(path.as_ref(), Format::Stl, self.to_stl(&MeshOptions::new(tolerance)))
    }

    /// Writes the shape in the format implied by the file extension: `.step`/`.stp`,
    /// `.iges`/`.igs`, `.brep`/`.brp` or `.stl` (meshed with `stl_tolerance`).
    pub fn export(&self, path: impl AsRef<Path>, stl_tolerance: f64) -> Result<()> {
        let path = path.as_ref();
        let format = Format::from_path(path)?;
        Self::write_file(path, format, self.to_bytes(format, &MeshOptions::new(stl_tolerance)))
    }

    /// Reads a shape in the format implied by the file extension (STEP, IGES or BREP).
    pub fn import(path: impl AsRef<Path>) -> Result<Shape> {
        let path = path.as_ref();
        match Format::from_path(path)? {
            Format::Step => Shape::read_step(path),
            Format::Iges => Shape::read_iges(path),
            Format::Brep => Shape::read_brep(path),
            Format::Stl => Err(unsupported(path)),
        }
    }
}

/// Adds the file name to an error about the file's contents.
fn with_path(error: Error, format: Format, path: &Path) -> Error {
    match error {
        Error::Io(_) => file_error("read", format, path, "not a valid file"),
        other => other,
    }
}

fn unsupported(path: &Path) -> Error {
    Error::Io(format!(
        "unsupported file type {} (expected .step, .stp, .iges, .igs, .brep, .brp or .stl)",
        path.display()
    ))
}
