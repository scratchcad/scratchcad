mod common;

use common::{assert_close, make_box, pnt, subshapes, EPS};
use scratchcad_occt_sys::{
    b_rep, b_rep_lib, b_rep_mesh, gp, poly, top_abs::TopAbs_ShapeEnum, top_loc, topo_ds::TopoDS,
};

#[test]
fn incremental_mesh_triangulates_every_face() {
    let solid = make_box(10.0, 10.0, 10.0);
    let mesh = b_rep_mesh::IncrementalMesh_new(&solid, 0.01).unwrap();
    assert!(mesh.IsDone());
    let meshed = mesh.Shape().unwrap();

    let mut triangles = 0;
    let mut area = 0.0;
    for face_shape in subshapes(meshed, TopAbs_ShapeEnum::TopAbs_FACE) {
        let face = TopoDS::Face(&face_shape).unwrap();
        let mut location = top_loc::Location_new();
        let handle = b_rep::BRep_Tool_Triangulation(face, location.pin_mut()).unwrap();
        assert!(!handle.IsNull());
        let triangulation = poly::Handle_Poly_Triangulation_Get(&handle).unwrap();
        assert!(triangulation.NbNodes() >= 4);
        let _connect = poly::Connect_new(&handle).unwrap();

        b_rep_lib::BRepLib_ToolTriangulatedShape::ComputeNormals(face, &handle).unwrap();
        assert!(triangulation.HasNormals());
        assert!(triangulation.HasUVNodes());
        let normal = poly::Poly_Triangulation_Normal(triangulation, 1).unwrap();
        assert_close(
            (normal.X().powi(2) + normal.Y().powi(2) + normal.Z().powi(2)).sqrt(),
            1.0,
            1e-6,
        );
        let _uv = poly::Poly_Triangulation_UV(triangulation, 1).unwrap();

        for i in 1..=triangulation.NbTriangles() {
            let triangle = triangulation.Triangle(i).unwrap();
            let corners: Vec<_> = (1..=3)
                .map(|c| {
                    poly::Poly_Triangulation_Node(triangulation, triangle.Value(c).unwrap())
                        .unwrap()
                })
                .collect();
            let (a, b, c) = (&corners[0], &corners[1], &corners[2]);
            let ab = [b.X() - a.X(), b.Y() - a.Y(), b.Z() - a.Z()];
            let ac = [c.X() - a.X(), c.Y() - a.Y(), c.Z() - a.Z()];
            let cross = [
                ab[1] * ac[2] - ab[2] * ac[1],
                ab[2] * ac[0] - ab[0] * ac[2],
                ab[0] * ac[1] - ab[1] * ac[0],
            ];
            area += (cross[0].powi(2) + cross[1].powi(2) + cross[2].powi(2)).sqrt() / 2.0;
            triangles += 1;
        }
        assert!(triangulation.Triangle(0).is_err());
        assert!(poly::Poly_Triangulation_Node(triangulation, triangulation.NbNodes() + 1).is_err());
    }
    assert!(triangles >= 12);
    assert_close(area, 600.0, 1e-6);
}

#[test]
fn build_a_triangulation_by_hand() {
    let mut triangulation = poly::Triangulation_new(3, 1, true, true);
    assert_eq!(triangulation.NbNodes(), 3);
    assert_eq!(triangulation.NbTriangles(), 1);
    triangulation.pin_mut().SetNode(1, &pnt(0.0, 0.0, 0.0)).unwrap();
    triangulation.pin_mut().SetNode(2, &pnt(1.0, 0.0, 0.0)).unwrap();
    triangulation.pin_mut().SetNode(3, &pnt(0.0, 1.0, 0.0)).unwrap();
    for i in 1..=3 {
        triangulation.pin_mut().SetNormal(i, &gp::gp_Dir_new(0.0, 0.0, 1.0).unwrap()).unwrap();
    }
    triangulation.pin_mut().SetUVNode(2, &gp::new_point_2d(1.0, 0.0)).unwrap();
    triangulation.pin_mut().SetTriangle(1, &poly::Triangle_new(1, 2, 3)).unwrap();
    assert!(triangulation.pin_mut().SetNode(4, &pnt(0.0, 0.0, 0.0)).is_err());
    assert!(triangulation.pin_mut().SetTriangle(2, &poly::Triangle_new(1, 2, 3)).is_err());

    assert!(triangulation.HasNormals());
    assert!(triangulation.HasUVNodes());
    assert_eq!(poly::Poly_Triangulation_UV(&triangulation, 2).unwrap().X(), 1.0);
    assert_eq!(poly::Poly_Triangulation_Normal(&triangulation, 3).unwrap().Z(), 1.0);
    assert_eq!(poly::Poly_Triangulation_Node(&triangulation, 2).unwrap().X(), 1.0);
    let triangle = triangulation.Triangle(1).unwrap();
    assert_eq!((triangle.Value(1).unwrap(), triangle.Value(3).unwrap()), (1, 3));
    assert!(triangle.Value(4).is_err());

    let handle = poly::Handle_Poly_Triangulation_new(triangulation);
    assert!(!handle.IsNull());
    assert_eq!(poly::Handle_Poly_Triangulation_Get(&handle).unwrap().NbNodes(), 3);
}

#[test]
fn faces_without_a_mesh_have_no_triangulation() {
    let solid = make_box(1.0, 1.0, 1.0);
    let face = &subshapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE)[0];
    let mut location = top_loc::Location_new();
    let handle =
        b_rep::BRep_Tool_Triangulation(TopoDS::Face(face).unwrap(), location.pin_mut()).unwrap();
    assert!(handle.IsNull());
    let err = poly::Handle_Poly_Triangulation_Get(&handle).err().unwrap();
    assert!(err.what().starts_with("Standard_NullObject"), "{}", err.what());
    let _ = EPS;
}
