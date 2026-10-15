//! Export formats: exact B-rep geometry (STEP, IGES, BREP) written by
//! OpenCASCADE, and triangle meshes (STL, OBJ, 3MF) written from the welded
//! mesh, so shared edges are watertight.

use std::{fmt::Write as _, io::Write as _};

use scratchcad_occt_rhai::{Error, Format, Mesh, MeshOptions, Shape};

use serde::{Deserialize, Serialize};

use crate::error::ApiError;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum ExportFormat {
    Step,
    Iges,
    Brep,
    Stl,
    Obj,
    ThreeMf,
}

impl ExportFormat {
    pub const ALL: [ExportFormat; 6] = [
        ExportFormat::Step,
        ExportFormat::Iges,
        ExportFormat::Brep,
        ExportFormat::Stl,
        ExportFormat::Obj,
        ExportFormat::ThreeMf,
    ];

    /// The format for a file extension (case-insensitive): `step`/`stp`,
    /// `iges`/`igs`, `brep`/`brp`, `stl`, `obj` or `3mf`
    pub fn from_extension(extension: &str) -> Option<Self> {
        match extension.to_ascii_lowercase().as_str() {
            "obj" => Some(Self::Obj),
            "3mf" => Some(Self::ThreeMf),
            other => Format::from_extension(other).map(|f| match f {
                Format::Step => Self::Step,
                Format::Iges => Self::Iges,
                Format::Brep => Self::Brep,
                Format::Stl => Self::Stl,
            }),
        }
    }

    /// OpenCASCADE's writer for exact formats
    fn occt(self) -> Option<Format> {
        match self {
            Self::Step => Some(Format::Step),
            Self::Iges => Some(Format::Iges),
            Self::Brep => Some(Format::Brep),
            Self::Stl | Self::Obj | Self::ThreeMf => None,
        }
    }

    pub fn extension(self) -> &'static str {
        match self {
            Self::Obj => "obj",
            Self::ThreeMf => "3mf",
            Self::Stl => Format::Stl.extension(),
            exact => exact.occt().map_or("", Format::extension),
        }
    }

    pub fn media_type(self) -> &'static str {
        match self {
            Self::Obj => "model/obj",
            Self::ThreeMf => "model/3mf",
            Self::Stl => Format::Stl.media_type(),
            exact => exact.occt().map_or("", Format::media_type),
        }
    }

    /// Whether the format stores a triangle mesh rather than exact geometry
    pub fn is_mesh(self) -> bool {
        self.occt().is_none()
    }

    /// The extensions, for messages: "step, iges, brep, stl, obj or 3mf"
    pub fn names() -> String {
        let names: Vec<_> = Self::ALL.iter().map(|f| f.extension()).collect();
        format!(
            "{} or {}",
            names[..names.len() - 1].join(", "),
            names[names.len() - 1]
        )
    }
}

/// The shape in an exact format: STEP, IGES or BREP
pub fn exact(shape: &Shape, format: ExportFormat) -> Result<Vec<u8>, ApiError> {
    let occt = format
        .occt()
        .ok_or_else(|| ApiError::Internal(format!("{format:?} is a mesh format")))?;
    // The mesh options only apply to STL, which is written from the mesh.
    shape
        .to_bytes(occt, &MeshOptions::new(1.0))
        .map_err(|e| export_error(e, occt))
}

fn export_error(e: Error, format: Format) -> ApiError {
    match e {
        Error::Io(m) => ApiError::ExportFailed(m),
        other => ApiError::ExportFailed(format!("{format} export failed: {other}")),
    }
}

/// A welded mesh in a mesh format: binary STL, OBJ or 3MF
pub fn mesh(welded: &Mesh, format: ExportFormat) -> Result<Vec<u8>, ApiError> {
    match format {
        ExportFormat::Stl => Ok(welded.to_stl()),
        ExportFormat::Obj => Ok(obj(welded)),
        ExportFormat::ThreeMf => three_mf(welded),
        exact => Err(ApiError::Internal(format!(
            "{exact:?} is not a mesh format"
        ))),
    }
}

/// Wavefront OBJ: shared vertices and 1-based triangles.  Normals are left
/// out: averaged over sharp edges they would round them off.
///
/// Coordinates are written as `f32`, as in STL, in Rust's shortest form that
/// reads back exactly (`10.0`, `2.5e-15`), which both OBJ and 3MF accept.
pub fn obj(welded: &Mesh) -> Vec<u8> {
    let mut out = String::with_capacity(32 * welded.vertex_count() + 24 * welded.triangle_count());
    let _ = writeln!(
        out,
        "# {} vertices, {} triangles, written by scratchcad\no shape",
        welded.vertex_count(),
        welded.triangle_count()
    );
    for v in &welded.vertices {
        let [x, y, z] = v.as_vec3().to_array();
        let _ = writeln!(out, "v {x:?} {y:?} {z:?}");
    }
    for [a, b, c] in welded.indices.as_chunks::<3>().0 {
        let _ = writeln!(out, "f {} {} {}", a + 1, b + 1, c + 1);
    }
    out.into_bytes()
}

const CONTENT_TYPES: &str = r#"<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/>
</Types>
"#;

const RELATIONSHIPS: &str = r#"<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>
</Relationships>
"#;

/// The 3MF model part: one object holding the whole mesh, in millimetres
fn three_mf_model(welded: &Mesh) -> String {
    let mut out = String::with_capacity(48 * welded.vertex_count() + 40 * welded.triangle_count());
    out.push_str(concat!(
        r#"<?xml version="1.0" encoding="UTF-8"?>"#,
        "\n",
        r#"<model unit="millimeter" xml:lang="en-US" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">"#,
        "\n",
        r#"<metadata name="Application">scratchcad</metadata>"#,
        "\n<resources>\n",
        r#"<object id="1" type="model"><mesh><vertices>"#,
        "\n",
    ));
    for v in &welded.vertices {
        let [x, y, z] = v.as_vec3().to_array();
        let _ = writeln!(out, r#"<vertex x="{x:?}" y="{y:?}" z="{z:?}"/>"#);
    }
    out.push_str("</vertices><triangles>\n");
    for [a, b, c] in welded.indices.as_chunks::<3>().0 {
        let _ = writeln!(out, r#"<triangle v1="{a}" v2="{b}" v3="{c}"/>"#);
    }
    out.push_str(concat!(
        "</triangles></mesh></object>\n</resources>\n",
        r#"<build><item objectid="1"/></build>"#,
        "\n</model>\n",
    ));
    out
}

/// 3D Manufacturing Format: the mesh in a ZIP package
pub fn three_mf(welded: &Mesh) -> Result<Vec<u8>, ApiError> {
    zip(&[
        ("[Content_Types].xml", CONTENT_TYPES.as_bytes()),
        ("_rels/.rels", RELATIONSHIPS.as_bytes()),
        ("3D/3dmodel.model", three_mf_model(welded).as_bytes()),
    ])
}

/// A ZIP archive of deflated files, as 3MF packages are.  Entries are dated
/// 1980-01-01, so the same input gives the same bytes.
pub fn zip(files: &[(&str, &[u8])]) -> Result<Vec<u8>, ApiError> {
    const VERSION: u16 = 20; // 2.0: deflate
    const DEFLATE: u16 = 8;
    const DOS_DATE: u16 = (1 << 5) | 1; // 1980-01-01
    let too_big = || ApiError::LimitExceeded("the 3MF package would be larger than 4 GiB".into());
    let u32_of = |n: usize| u32::try_from(n).map_err(|_| too_big());

    let mut out = Vec::new();
    let mut directory = Vec::new();
    for (name, data) in files {
        let mut encoder =
            flate2::write::DeflateEncoder::new(Vec::new(), flate2::Compression::default());
        encoder
            .write_all(data)
            .and_then(|_| encoder.try_finish())
            .map_err(|e| ApiError::Internal(format!("compressing {name}: {e}")))?;
        let compressed = encoder.get_ref();
        let crc = crc32fast::hash(data);
        let offset = u32_of(out.len())?;
        // Fields shared by the local header and the directory entry, from
        // "version needed" to "file name length"
        let mut common = Vec::with_capacity(26);
        for v in [VERSION, 0, DEFLATE, 0, DOS_DATE] {
            common.extend(v.to_le_bytes());
        }
        for v in [crc, u32_of(compressed.len())?, u32_of(data.len())?] {
            common.extend(v.to_le_bytes());
        }
        common.extend((name.len() as u16).to_le_bytes());

        out.extend(0x0403_4b50_u32.to_le_bytes());
        out.extend(&common);
        out.extend(0u16.to_le_bytes()); // extra field length
        out.extend(name.as_bytes());
        out.extend(compressed);

        directory.extend(0x0201_4b50_u32.to_le_bytes());
        directory.extend(VERSION.to_le_bytes()); // version made by
        directory.extend(&common);
        // Extra, comment, disk, internal and external attributes
        directory.extend([0u8; 2 + 2 + 2 + 2 + 4]);
        directory.extend(offset.to_le_bytes());
        directory.extend(name.as_bytes());
    }
    let start = u32_of(out.len())?;
    let size = u32_of(directory.len())?;
    let count = files.len() as u16;
    out.extend(directory);
    out.extend(0x0605_4b50_u32.to_le_bytes());
    out.extend([0u8; 4]); // disk numbers
    out.extend(count.to_le_bytes());
    out.extend(count.to_le_bytes());
    out.extend(size.to_le_bytes());
    out.extend(start.to_le_bytes());
    out.extend(0u16.to_le_bytes()); // comment length
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;
    use scratchcad_occt_rhai::eval_shape;
    use std::io::Read;

    fn cube_mesh() -> Mesh {
        eval_shape("cube(10)").unwrap().mesh(0.1).unwrap().welded()
    }

    #[test]
    fn formats_by_extension() {
        for (ext, format, media) in [
            ("step", ExportFormat::Step, "model/step"),
            ("STP", ExportFormat::Step, "model/step"),
            ("igs", ExportFormat::Iges, "model/iges"),
            ("brep", ExportFormat::Brep, "application/octet-stream"),
            ("stl", ExportFormat::Stl, "model/stl"),
            ("obj", ExportFormat::Obj, "model/obj"),
            ("3MF", ExportFormat::ThreeMf, "model/3mf"),
        ] {
            assert_eq!(ExportFormat::from_extension(ext), Some(format), "{ext}");
            assert_eq!(format.media_type(), media);
            assert_eq!(
                ExportFormat::from_extension(format.extension()),
                Some(format)
            );
        }
        assert_eq!(ExportFormat::from_extension("dxf"), None);
        assert_eq!(ExportFormat::names(), "step, iges, brep, stl, obj or 3mf");
        let meshes: Vec<_> = ExportFormat::ALL
            .into_iter()
            .filter(|f| f.is_mesh())
            .collect();
        assert_eq!(
            meshes,
            [ExportFormat::Stl, ExportFormat::Obj, ExportFormat::ThreeMf]
        );
    }

    #[test]
    fn exact_formats() {
        let shape = eval_shape("cube(10)").unwrap();
        let step = exact(&shape, ExportFormat::Step).unwrap();
        assert!(String::from_utf8_lossy(&step).starts_with("ISO-10303-21;"));
        let brep = exact(&shape, ExportFormat::Brep).unwrap();
        let back = Shape::from_bytes(Format::Brep, &brep).unwrap();
        assert!((back.volume().unwrap() - 1000.0).abs() < 1e-9);
        let iges = exact(&shape, ExportFormat::Iges).unwrap();
        assert!(iges.len() > 1000);
        assert!(matches!(
            exact(&shape, ExportFormat::Stl),
            Err(ApiError::Internal(_))
        ));
    }

    #[test]
    fn export_errors() {
        let e = export_error(Error::Io("failed to write STEP".into()), Format::Step);
        assert!(matches!(e, ApiError::ExportFailed(m) if m == "failed to write STEP"));
        let e = export_error(Error::Occt("Standard_Failure".into()), Format::Iges);
        assert!(matches!(e, ApiError::ExportFailed(m) if m.starts_with("IGES export failed")));
    }

    #[test]
    fn stl_and_obj() {
        let mesh = cube_mesh();
        let stl = super::mesh(&mesh, ExportFormat::Stl).unwrap();
        assert_eq!(stl.len(), 84 + 50 * 12);
        let text = String::from_utf8(super::mesh(&mesh, ExportFormat::Obj).unwrap()).unwrap();
        assert!(text.starts_with("# 8 vertices, 12 triangles"));
        assert_eq!(text.lines().filter(|l| l.starts_with("v ")).count(), 8);
        let faces: Vec<_> = text.lines().filter(|l| l.starts_with("f ")).collect();
        assert_eq!(faces.len(), 12);
        // 1-based indices
        assert!(faces.iter().all(|f| !f.split(' ').any(|i| i == "0")));
        assert!(text.contains("v 10.0 10.0 10.0\n"));
        assert!(matches!(
            super::mesh(&mesh, ExportFormat::Brep),
            Err(ApiError::Internal(_))
        ));
    }

    /// Reads a ZIP archive as `zip` writes it, checking its structure
    fn unzip(bytes: &[u8]) -> Vec<(String, Vec<u8>)> {
        let u16_at = |i: usize| u16::from_le_bytes(bytes[i..i + 2].try_into().unwrap()) as usize;
        let u32_at = |i: usize| u32::from_le_bytes(bytes[i..i + 4].try_into().unwrap()) as usize;
        let end = bytes.len() - 22;
        assert_eq!(u32_at(end), 0x0605_4b50);
        let count = u16_at(end + 10);
        let mut at = u32_at(end + 16);
        assert_eq!(at + u32_at(end + 12), end);
        let mut files = vec![];
        for _ in 0..count {
            assert_eq!(u32_at(at), 0x0201_4b50);
            let (crc, size) = (u32_at(at + 16) as u32, u32_at(at + 24));
            let name_len = u16_at(at + 28);
            let local = u32_at(at + 42);
            let name = String::from_utf8(bytes[at + 46..at + 46 + name_len].to_vec()).unwrap();
            assert_eq!(u32_at(local), 0x0403_4b50);
            let data_at = local + 30 + u16_at(local + 26) + u16_at(local + 28);
            let compressed = &bytes[data_at..data_at + u32_at(local + 18)];
            let mut data = vec![];
            flate2::read::DeflateDecoder::new(compressed)
                .read_to_end(&mut data)
                .unwrap();
            assert_eq!((data.len(), crc32fast::hash(&data)), (size, crc));
            files.push((name, data));
            at += 46 + name_len;
        }
        files
    }

    #[test]
    fn zip_archives_round_trip() {
        let files = [("a.txt", &b"hello hello hello"[..]), ("dir/b", &b""[..])];
        let bytes = zip(&files).unwrap();
        assert_eq!(bytes, zip(&files).unwrap(), "reproducible");
        let back = unzip(&bytes);
        assert_eq!(back.len(), 2);
        assert_eq!((back[0].0.as_str(), back[0].1.as_slice()), files[0]);
        assert_eq!((back[1].0.as_str(), back[1].1.as_slice()), files[1]);
    }

    #[test]
    fn three_mf_package() {
        let bytes = super::mesh(&cube_mesh(), ExportFormat::ThreeMf).unwrap();
        let files = unzip(&bytes);
        let names: Vec<_> = files.iter().map(|(n, _)| n.as_str()).collect();
        assert_eq!(
            names,
            ["[Content_Types].xml", "_rels/.rels", "3D/3dmodel.model"]
        );
        let model = String::from_utf8(files[2].1.clone()).unwrap();
        assert!(model.contains(r#"unit="millimeter""#));
        assert_eq!(model.matches("<vertex ").count(), 8);
        assert_eq!(model.matches("<triangle ").count(), 12);
        assert!(model.contains(r#"<item objectid="1"/>"#));
    }
}
