mod common;

use common::{assert_close, cube10, err, err_contains, v};
use scratchcad_occt_rhai::{DVec3, Error, Selection, Shape, ShapeType};

fn centers(selection: &Selection) -> Vec<DVec3> {
    selection.iter().map(|s| s.center().unwrap()).collect()
}

#[test]
fn direction_selectors_on_a_box() {
    let cube = cube10();
    let faces = cube.faces();
    assert_eq!(faces.len(), 6);

    let top = faces.select(">Z").unwrap();
    assert_eq!(top.len(), 1);
    assert_close(top.first().unwrap().center().unwrap().z, 10.0, 1e-9);
    assert_close(faces.select("<Z").unwrap().single().unwrap().center().unwrap().z, 0.0, 1e-9);
    assert_eq!(faces.select("|Z").unwrap().len(), 2);
    assert_eq!(faces.select("#Z").unwrap().len(), 4);
    assert!(faces.select("+Z").unwrap().single().unwrap().is_same(&top.first().unwrap()));
    assert_close(faces.select("-Z").unwrap().single().unwrap().center().unwrap().z, 0.0, 1e-9);
    assert_eq!(faces.select("%PLANE").unwrap().len(), 6);
    assert!(faces.select("%cylinder").unwrap().is_empty());

    // Levels along Z: top (z = 10), the four sides (z = 5), bottom (z = 0).
    assert_eq!(faces.select(">Z[1]").unwrap().len(), 4);
    assert_close(faces.select(">Z[-1]").unwrap().single().unwrap().center().unwrap().z, 0.0, 1e-9);
    assert!(faces.select(">Z[5]").unwrap().is_empty());
    assert!(faces.select(">Z[-4]").unwrap().is_empty());
    assert_eq!(faces.select("<Z[1]").unwrap().len(), 4);

    let edges = cube.edges();
    assert_eq!(edges.select("|Z").unwrap().len(), 4);
    assert_eq!(edges.select("#Z").unwrap().len(), 8);
    assert_eq!(edges.select(">Z").unwrap().len(), 4);
    assert_eq!(edges.select("+Z").unwrap().len() + edges.select("-Z").unwrap().len(), 4);
    assert_eq!(edges.select("%LINE").unwrap().len(), 12);
    let corner = cube.vertices().select(">(1, 1, 1)").unwrap().single().unwrap();
    assert_eq!(corner.point().unwrap(), v(10.0, 10.0, 10.0));
    assert_eq!(cube.vertices().select(">(1, 1, 0)").unwrap().len(), 2);
}

#[test]
fn boolean_selectors() {
    let edges = cube10().edges();
    assert_eq!(edges.select("|Z and >X").unwrap().len(), 2);
    assert_eq!(edges.select("not |Z").unwrap().len(), 8);
    assert_eq!(edges.select("|X or |Y").unwrap().len(), 8);
    assert_eq!(edges.select("|Z exc >X").unwrap().len(), 2);
    assert_eq!(edges.select("(|X or |Y) and >Z").unwrap().len(), 4);
    assert_eq!(edges.select("|Z and >X and >Y").unwrap().len(), 1);
    // "or" keeps the original order.
    let ordered = edges.select("|Y or |X").unwrap();
    let positions: Vec<_> =
        ordered.iter().map(|e| edges.iter().position(|o| o.is_same(e)).unwrap()).collect();
    assert!(positions.windows(2).all(|w| w[0] < w[1]));
    err_contains(edges.select(">"), "invalid selector");
}

#[test]
fn selectors_on_curved_shapes() {
    let cylinder = Shape::cylinder(1.0, 2.0).unwrap();
    assert_eq!(cylinder.faces().select("%CYLINDER").unwrap().len(), 1);
    assert_eq!(cylinder.faces().select("%PLANE").unwrap().len(), 2);
    // The curved face has no single normal, so it is never "parallel" to anything.
    assert_eq!(cylinder.faces().select("|Z").unwrap().len(), 2);
    assert_eq!(cylinder.faces().select("#Z").unwrap().len(), 0);
    assert_eq!(cylinder.edges().select("%CIRCLE").unwrap().len(), 2);
    assert_eq!(cylinder.edges().select("%LINE").unwrap().len(), 1, "the seam");
    assert_eq!(cylinder.edges().select("|Z").unwrap().len(), 1);
    // Vertices have no geometry type.
    assert!(cylinder.vertices().select("%LINE").unwrap().is_empty());
}

#[test]
fn explicit_filters() {
    let faces = cube10().faces();
    assert_eq!(faces.farthest(DVec3::X).unwrap().len(), 1);
    assert_close(faces.nearest(DVec3::X).unwrap().single().unwrap().center().unwrap().x, 0.0, 1e-9);
    assert_eq!(faces.nth_farthest(DVec3::Y, 1).unwrap().len(), 4);
    assert_eq!(faces.parallel_to(DVec3::X).unwrap().len(), 2);
    assert_eq!(faces.perpendicular_to(DVec3::X).unwrap().len(), 4);
    assert_eq!(faces.facing(DVec3::NEG_X).unwrap().len(), 1);
    assert_eq!(faces.of_type(" Plane ").unwrap().len(), 6);
    for result in [
        faces.farthest(DVec3::ZERO),
        faces.parallel_to(DVec3::ZERO),
        faces.perpendicular_to(DVec3::ZERO),
        faces.facing(DVec3::ZERO),
    ] {
        err_contains(result, "zero-length");
    }

    let big = faces.filter(|f| Ok(f.center()?.z > 4.0)).unwrap();
    assert_eq!(big.len(), 5);
    let failing = faces.filter(|f| f.radius().map(|_| true));
    err_contains(failing, "expected edge");

    let sorted = faces.sort_by_key(|f| Ok(-f.center()?.z)).unwrap();
    assert_close(sorted.first().unwrap().center().unwrap().z, 10.0, 1e-9);
    assert_close(sorted.last().unwrap().center().unwrap().z, 0.0, 1e-9);
    assert!(faces.sort_by_key(|f| f.point().map(|p| p.x)).is_err());
}

#[test]
fn indexing_and_set_operations() {
    let cube = cube10();
    let faces = cube.faces();
    assert!(faces.get(0).unwrap().is_same(&faces.first().unwrap()));
    assert!(faces.get(-1).unwrap().is_same(&faces.last().unwrap()));
    assert!(faces.get(-6).unwrap().is_same(&faces.first().unwrap()));
    assert!(matches!(err(faces.get(6)), Error::IndexOutOfRange { index: 6, len: 6 }));
    assert!(matches!(err(faces.get(-7)), Error::IndexOutOfRange { index: -7, len: 6 }));

    let empty = Selection::default();
    assert!(empty.is_empty());
    assert!(matches!(err(empty.first()), Error::EmptySelection(_)));
    assert!(matches!(err(empty.last()), Error::EmptySelection(_)));
    assert!(matches!(err(empty.single()), Error::EmptySelection(_)));
    err_contains(faces.single(), "found 6");

    let top = faces.select(">Z").unwrap();
    let sides = faces.select("#Z").unwrap();
    let union = top.union(&sides).union(&top);
    assert_eq!(union.len(), 5);
    assert_eq!(union.intersect(&top).len(), 1);
    assert_eq!(faces.subtract(&union).len(), 1);

    let compound = sides.to_compound().unwrap();
    assert_eq!(compound.shape_type(), ShapeType::Compound);
    assert_eq!(compound.faces().len(), 4);

    let collected: Selection = faces.iter().take(2).cloned().collect();
    assert_eq!(collected.len(), 2);
    let mut count = 0;
    for face in &faces {
        assert_eq!(face.shape_type(), ShapeType::Face);
        count += 1;
    }
    assert_eq!(count, 6);
    // Owned iteration works whether or not the selection is shared.
    let shared = faces.clone();
    assert_eq!(shared.into_iter().count(), 6);
    assert_eq!(cube.faces().into_iter().count(), 6);
    assert_eq!(centers(&faces).len(), 6);

    assert_eq!(faces.to_string(), "Selection([6 face])");
    let mixed = Selection::new(vec![
        faces.get(0).unwrap(),
        cube.edges().get(0).unwrap(),
        faces.get(1).unwrap(),
    ]);
    assert_eq!(format!("{mixed:?}"), "Selection([2 face, 1 edge])");
    assert_eq!(Selection::default().to_string(), "Selection([])");
}
