mod common;

use common::{assert_close, err_contains, temp_dir};
use scratchcad_occt_rhai::{Error, Format, MeshOptions, Shape, ShapeType};
use std::path::Path;

#[test]
fn step_round_trip() {
    let dir = temp_dir();
    let path = dir.path().join("part.step");
    let part = Shape::cube(2.0).unwrap().fillet_all(0.5).unwrap();
    part.write_step(&path).unwrap();
    let back = Shape::read_step(&path).unwrap();
    assert_eq!(back.shape_type(), ShapeType::Solid);
    assert_close(back.volume().unwrap(), part.volume().unwrap(), 1e-6);
    let imported = Shape::import(&path).unwrap();
    assert_close(imported.volume().unwrap(), part.volume().unwrap(), 1e-6);
}

#[test]
fn iges_round_trip() {
    let dir = temp_dir();
    let path = dir.path().join("part.igs");
    let part = Shape::cylinder(1.0, 3.0).unwrap();
    part.write_iges(&path).unwrap();
    let back = Shape::read_iges(&path).unwrap();
    assert!(!back.faces().is_empty());
    assert!(Shape::import(dir.path().join("part.igs")).is_ok());
    part.export(dir.path().join("again.IGES"), 0.1).unwrap();
    assert!(dir.path().join("again.IGES").exists());
}

#[test]
fn brep_round_trip_is_exact() {
    let dir = temp_dir();
    let path = dir.path().join("part.brep");
    let part = Shape::torus(3.0, 1.0).unwrap();
    part.write_brep(&path).unwrap();
    let back = Shape::read_brep(&path).unwrap();
    assert_close(back.volume().unwrap(), part.volume().unwrap(), 1e-9);
    part.export(dir.path().join("x.brp"), 0.1).unwrap();
    assert!(Shape::import(dir.path().join("x.brp")).is_ok());
}

#[test]
fn stl_export_is_binary() {
    let dir = temp_dir();
    let path = dir.path().join("part.stl");
    Shape::cube(1.0).unwrap().write_stl(&path, 0.1).unwrap();
    let bytes = std::fs::read(&path).unwrap();
    assert_eq!(u32::from_le_bytes(bytes[80..84].try_into().unwrap()), 12);
    assert_eq!(bytes.len(), 84 + 12 * 50);
    Shape::sphere(1.0).unwrap().export(dir.path().join("ball.stl"), 0.01).unwrap();
    assert!(std::fs::metadata(dir.path().join("ball.stl")).unwrap().len() > 1000);
    err_contains(Shape::cube(1.0).unwrap().write_stl(&path, 0.0), "mesh tolerance");
}

#[test]
fn round_trips_in_memory() {
    let part = Shape::cube(2.0).unwrap().fillet_all(0.5).unwrap();
    let volume = part.volume().unwrap();
    let stl = MeshOptions::new(0.1);
    for format in [Format::Step, Format::Brep] {
        let bytes = part.to_bytes(format, &stl).unwrap();
        let back = Shape::from_bytes(format, &bytes).unwrap();
        assert_close(back.volume().unwrap(), volume, 1e-6);
    }
    // IGES is written in memory but read only from files.
    let iges = part.to_bytes(Format::Iges, &stl).unwrap();
    err_contains(Shape::from_bytes(Format::Iges, &iges), "IGES can only be read from a file");
    let dir = temp_dir();
    std::fs::write(dir.path().join("part.igs"), &iges).unwrap();
    assert_eq!(
        Shape::read_iges(dir.path().join("part.igs")).unwrap().faces().len(),
        part.faces().len()
    );
    assert!(part.to_step().unwrap().starts_with(b"ISO-10303-21;"));
    assert!(part.to_brep().unwrap().starts_with(b"DBRep_DrawableShape"));
    let mesh = part.to_bytes(Format::Stl, &stl).unwrap();
    assert_eq!(mesh, part.to_stl(&stl).unwrap());
    assert_eq!(mesh.len(), 84 + 50 * part.mesh(0.1).unwrap().triangle_count());
    err_contains(Shape::from_bytes(Format::Stl, &mesh), "cannot be read as shapes");
}

#[test]
fn reading_junk_from_memory_fails() {
    for format in [Format::Step, Format::Brep] {
        let result = Shape::from_bytes(format, b"this is not a CAD file");
        assert!(matches!(result, Err(Error::Io(_))), "{format}: {result:?}");
    }
}

#[test]
fn formats() {
    for format in Format::ALL {
        assert_eq!(Format::from_extension(format.extension()), Some(format));
        assert_eq!(Format::from_extension(&format.extension().to_uppercase()), Some(format));
        assert_eq!(format.to_string(), format.name());
        assert!(format.media_type().contains('/'));
        assert_eq!(format.is_mesh(), format == Format::Stl);
    }
    assert_eq!(Format::from_extension("stp"), Some(Format::Step));
    assert_eq!(Format::from_extension("igs"), Some(Format::Iges));
    assert_eq!(Format::from_extension("brp"), Some(Format::Brep));
    assert_eq!(Format::from_extension("obj"), None);
    assert_eq!(Format::from_path(Path::new("a/b.STP")).unwrap(), Format::Step);
    err_contains(Format::from_path(Path::new("a/b")), "unsupported file type");
}

#[test]
fn file_errors() {
    let dir = temp_dir();
    let missing = dir.path().join("missing");
    for result in [
        Shape::read_step(missing.with_extension("step")),
        Shape::read_iges(missing.with_extension("igs")),
        Shape::read_brep(missing.with_extension("brep")),
    ] {
        assert!(matches!(result, Err(Error::Io(_))), "{result:?}");
    }
    err_contains(Shape::read_step(missing.with_extension("step")), "failed to read STEP file");

    let cube = Shape::cube(1.0).unwrap();
    let bad_dir = dir.path().join("no").join("such").join("dir");
    err_contains(cube.write_step(bad_dir.join("x.step")), "failed to write STEP file");
    err_contains(cube.write_iges(bad_dir.join("x.igs")), "failed to write IGES file");
    err_contains(cube.write_brep(bad_dir.join("x.brep")), "failed to write BREP file");
    err_contains(cube.write_stl(bad_dir.join("x.stl"), 0.1), "failed to write STL file");

    err_contains(cube.export(dir.path().join("x.obj"), 0.1), "unsupported file type");
    err_contains(cube.export(dir.path().join("no_extension"), 0.1), "unsupported file type");
    err_contains(Shape::import(dir.path().join("x.stl")), "unsupported file type");

    // A file with the right extension but the wrong content.
    let junk = dir.path().join("junk.step");
    std::fs::write(&junk, "not a step file").unwrap();
    assert!(Shape::read_step(&junk).is_err());
    let junk = dir.path().join("junk.brep");
    std::fs::write(&junk, "not a brep file").unwrap();
    assert!(Shape::read_brep(&junk).is_err());
}

#[test]
fn empty_shapes_cannot_be_exchanged() {
    let dir = temp_dir();
    let empty = Shape::empty().unwrap();
    // OCCT refuses to transfer an empty compound; whatever it decides must not crash.
    let step = empty.write_step(dir.path().join("empty.step"));
    let iges = empty.write_iges(dir.path().join("empty.igs"));
    for result in [step, iges] {
        if let Err(e) = result {
            assert!(matches!(e, Error::Io(_)), "{e}");
        }
    }
}

#[test]
fn concurrent_conversions() {
    let handles: Vec<_> = (0..4)
        .map(|i| {
            std::thread::spawn(move || {
                // Shapes are not Send, so each thread builds its own.
                let part = Shape::cube(1.0 + i as f64).unwrap();
                let step = Shape::from_step(&part.to_step().unwrap()).unwrap();
                let brep = Shape::from_brep(&part.to_brep().unwrap()).unwrap();
                (step.volume().unwrap(), brep.volume().unwrap())
            })
        })
        .collect();
    for (i, handle) in handles.into_iter().enumerate() {
        let expected = (1.0 + i as f64).powi(3);
        let (step, brep) = handle.join().unwrap();
        assert_close(step, expected, 1e-6);
        assert_close(brep, expected, 1e-9);
    }
}

#[test]
fn concurrent_file_access_is_serialized() {
    let dir = temp_dir();
    let paths: Vec<_> = (0..4).map(|i| dir.path().join(format!("part{i}.step"))).collect();
    let handles: Vec<_> = paths
        .clone()
        .into_iter()
        .map(|path| {
            std::thread::spawn(move || {
                // Shapes are not Send, so each thread builds its own.
                Shape::cube(1.0).unwrap().write_step(&path).unwrap();
                Shape::read_step(&path).unwrap().volume().unwrap()
            })
        })
        .collect();
    for handle in handles {
        assert_close(handle.join().unwrap(), 1.0, 1e-9);
    }
}
