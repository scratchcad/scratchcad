mod common;

use common::{
    assert_close, explore_count, first_subshape, make_box, make_box_at, pnt, subshapes,
    unique_count, EPS,
};
use scratchcad_occt_sys::{
    b_rep::{BRep_Builder_new, BRep_Builder_upcast_to_topods_builder, BRep_Tool, BRep_Tool_Pnt},
    b_rep_builder_api, gp,
    top_abs::{TopAbs_Orientation, TopAbs_ShapeEnum},
    top_exp::{self, TopExp},
    top_loc, top_tools,
    topo_ds::{self, TopoDS},
};

#[test]
fn explorer_and_maps_count_sub_shapes() {
    let solid = make_box(1.0, 2.0, 3.0);
    assert_eq!(explore_count(&solid, TopAbs_ShapeEnum::TopAbs_FACE), 6);
    // Each edge is shared by two faces, so the explorer visits it twice.
    assert_eq!(explore_count(&solid, TopAbs_ShapeEnum::TopAbs_EDGE), 24);
    assert_eq!(unique_count(&solid, TopAbs_ShapeEnum::TopAbs_EDGE), 12);
    assert_eq!(unique_count(&solid, TopAbs_ShapeEnum::TopAbs_VERTEX), 8);
    assert_eq!(unique_count(&solid, TopAbs_ShapeEnum::TopAbs_SHELL), 1);
    assert_eq!(unique_count(&solid, TopAbs_ShapeEnum::TopAbs_SOLID), 1);

    let mut explorer = top_exp::TopExp_Explorer_new(&solid, TopAbs_ShapeEnum::TopAbs_WIRE);
    let mut wires = 0;
    while explorer.More() {
        let owned = top_exp::ExplorerCurrentShape(&explorer).unwrap();
        assert!(owned.IsSame(explorer.Current().unwrap()));
        assert_eq!(owned.ShapeType(), TopAbs_ShapeEnum::TopAbs_WIRE);
        wires += 1;
        explorer.pin_mut().Next();
    }
    assert_eq!(wires, 6);
}

#[test]
fn shape_identity_and_properties() {
    let solid = make_box(1.0, 1.0, 1.0);
    let copy = topo_ds::TopoDS_Shape_to_owned(&solid);
    let other = make_box(1.0, 1.0, 1.0);
    assert!(solid.IsSame(&copy));
    assert!(solid.IsEqual(&copy));
    assert!(!solid.IsSame(&other));
    assert!(!solid.IsNull());
    assert!(topo_ds::TopoDS_Shape_new().IsNull());
    assert_eq!(solid.ShapeType(), TopAbs_ShapeEnum::TopAbs_SOLID);
    assert_eq!(solid.Orientation(), TopAbs_Orientation::TopAbs_FORWARD);
    assert_eq!(solid.NbChildren(), 1);

    let shell = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_SHELL);
    assert_eq!(shell.NbChildren(), 6);
    assert!(BRep_Tool::IsClosed(&shell));
    let wire = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_WIRE);
    assert!(BRep_Tool::IsClosed(&wire));
    let _ = shell.Closed();
}

#[test]
fn downcasts_and_upcasts_round_trip() {
    let solid = make_box(1.0, 1.0, 1.0);
    let face_shape = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_FACE);
    let face = TopoDS::Face(&face_shape).unwrap();
    let _ = face.Orientation();
    let owned_face = topo_ds::TopoDS_Face_to_owned(face);
    assert!(topo_ds::cast_face_to_shape(&owned_face).IsSame(&face_shape));
    assert!(topo_ds::cast_face_to_shape(&topo_ds::TopoDS_Face_new()).IsNull());

    let edge_shape = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_EDGE);
    let edge = topo_ds::TopoDS_Edge_to_owned(TopoDS::Edge(&edge_shape).unwrap());
    assert!(topo_ds::cast_edge_to_shape(&edge).IsSame(&edge_shape));

    let vertex_shape = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_VERTEX);
    let vertex = topo_ds::TopoDS_Vertex_to_owned(TopoDS::Vertex(&vertex_shape).unwrap());
    assert!(topo_ds::cast_vertex_to_shape(&vertex).IsSame(&vertex_shape));

    let wire_shape = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_WIRE);
    let wire = topo_ds::TopoDS_Wire_to_owned(TopoDS::Wire(&wire_shape).unwrap());
    assert!(topo_ds::cast_wire_to_shape(&wire).IsSame(&wire_shape));

    let shell_shape = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_SHELL);
    let shell = topo_ds::TopoDS_Shell_to_owned(TopoDS::Shell(&shell_shape).unwrap());
    assert!(topo_ds::cast_shell_to_shape(&shell).IsSame(&shell_shape));

    let solid_typed = topo_ds::TopoDS_Solid_to_owned(TopoDS::Solid(&solid).unwrap());
    assert!(topo_ds::cast_solid_to_shape(&solid_typed).IsSame(&solid));
}

#[test]
fn compounds_and_shells_can_be_assembled() {
    let builder = BRep_Builder_new();
    let builder = BRep_Builder_upcast_to_topods_builder(&builder);

    let mut compound = topo_ds::TopoDS_Compound_new();
    builder.MakeCompound(compound.pin_mut());
    let typed_copy = topo_ds::TopoDS_Compound_to_owned(&compound);
    assert!(!topo_ds::cast_compound_to_shape(&typed_copy).IsNull());
    let mut compound = topo_ds::TopoDS_Compound_as_shape(compound);
    builder.Add(compound.pin_mut(), &make_box(1.0, 1.0, 1.0)).unwrap();
    builder.Add(compound.pin_mut(), &make_box_at(5.0, 0.0, 0.0, 1.0, 1.0, 1.0)).unwrap();
    assert_eq!(compound.ShapeType(), TopAbs_ShapeEnum::TopAbs_COMPOUND);
    assert_eq!(compound.NbChildren(), 2);
    assert!(TopoDS::Compound(&compound).is_ok());
    assert_eq!(unique_count(&compound, TopAbs_ShapeEnum::TopAbs_SOLID), 2);

    // Faces from the box can be sewn back into a shell, which becomes a solid.
    let solid = make_box(1.0, 1.0, 1.0);
    let mut shell = topo_ds::TopoDS_Shell_new();
    builder.MakeShell(shell.pin_mut());
    let mut shell = topo_ds::TopoDS_Shell_as_shape(shell);
    for face in subshapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE) {
        builder.Add(shell.pin_mut(), &face).unwrap();
    }
    assert_eq!(shell.NbChildren(), 6);
    let mut make_solid =
        b_rep_builder_api::BRepBuilderAPI_MakeSolid_new(TopoDS::Shell(&shell).unwrap()).unwrap();
    make_solid.pin_mut().Build(&common::progress()).unwrap();
    assert!(make_solid.IsDone());
    assert_close(common::volume(make_solid.pin_mut().Shape().unwrap()), 1.0, 1e-6);

    // A solid cannot be added to a vertex.
    let vertex = first_subshape(&solid, TopAbs_ShapeEnum::TopAbs_VERTEX);
    let mut vertex = topo_ds::TopoDS_Shape_to_owned(&vertex);
    let err = builder.Add(vertex.pin_mut(), &solid).err().unwrap();
    assert!(err.what().starts_with("TopoDS_"), "{}", err.what());
}

#[test]
fn vertices_of_edges_and_wires() {
    let solid = make_box(1.0, 1.0, 1.0);
    let edges = subshapes(&solid, TopAbs_ShapeEnum::TopAbs_EDGE);
    let e1 = TopoDS::Edge(&edges[0]).unwrap();
    let first = top_exp::TopExp_FirstVertex(e1).unwrap();
    let last = top_exp::TopExp_LastVertex(e1).unwrap();
    let length = BRep_Tool_Pnt(&first).unwrap().Distance(&BRep_Tool_Pnt(&last).unwrap());
    assert_close(length, 1.0, EPS);

    let mut v1 = topo_ds::TopoDS_Vertex_to_owned(&first);
    let mut v2 = topo_ds::TopoDS_Vertex_to_owned(&first);
    TopExp::EdgeVertices(e1, v1.pin_mut(), v2.pin_mut(), true).unwrap();
    assert!(topo_ds::cast_vertex_to_shape(&v1).IsSame(topo_ds::cast_vertex_to_shape(&first)));
    assert!(topo_ds::cast_vertex_to_shape(&v2).IsSame(topo_ds::cast_vertex_to_shape(&last)));

    // Find an edge sharing a vertex with the first one.
    let mut common_vertex = topo_ds::TopoDS_Vertex_to_owned(&first);
    let shares = edges[1..]
        .iter()
        .filter(|e| {
            TopExp::CommonVertex(e1, TopoDS::Edge(e).unwrap(), common_vertex.pin_mut()).unwrap()
        })
        .count();
    assert_eq!(shares, 4, "each box edge touches 4 others");

    // An open wire made of two edges has distinct end vertices.
    let a = pnt(0.0, 0.0, 0.0);
    let b = pnt(1.0, 0.0, 0.0);
    let c = pnt(1.0, 1.0, 0.0);
    let mut e_ab = b_rep_builder_api::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&a, &b).unwrap();
    let mut e_bc = b_rep_builder_api::BRepBuilderAPI_MakeEdge_gp_Pnt_gp_Pnt(&b, &c).unwrap();
    let mut wire = b_rep_builder_api::BRepBuilderAPI_MakeWire_edge_edge(
        e_ab.pin_mut().Edge().unwrap(),
        e_bc.pin_mut().Edge().unwrap(),
    )
    .unwrap();
    let wire = topo_ds::TopoDS_Wire_to_owned(wire.pin_mut().Wire().unwrap());
    let mut w1 = topo_ds::TopoDS_Vertex_to_owned(&first);
    let mut w2 = topo_ds::TopoDS_Vertex_to_owned(&first);
    TopExp::TopExp_WireVertices(&wire, w1.pin_mut(), w2.pin_mut()).unwrap();
    assert_close(BRep_Tool_Pnt(&w1).unwrap().Distance(&a), 0.0, EPS);
    assert_close(BRep_Tool_Pnt(&w2).unwrap().Distance(&c), 0.0, EPS);
    assert!(!BRep_Tool::IsClosed(topo_ds::cast_wire_to_shape(&wire)));
}

#[test]
fn ancestor_maps() {
    let solid = make_box(1.0, 1.0, 1.0);
    let mut map = top_tools::new_indexed_data_map_of_shape_list_of_shape();
    TopExp::MapShapesAndAncestors(
        &solid,
        TopAbs_ShapeEnum::TopAbs_EDGE,
        TopAbs_ShapeEnum::TopAbs_FACE,
        map.pin_mut(),
    )
    .unwrap();
    assert_eq!(map.Extent(), 12);
    for i in 1..=map.Extent() {
        assert_eq!(map.FindFromIndex(i).unwrap().Size(), 2);
        let edge = map.FindKey(i).unwrap();
        assert_eq!(map.FindIndex(edge), i);
        let faces = map.FindFromKey(edge).unwrap();
        let faces = topo_ds::shape_list_to_vector(faces);
        assert_eq!(faces.len(), 2);
        assert!(faces.iter().all(|f| f.ShapeType() == TopAbs_ShapeEnum::TopAbs_FACE));
    }
    assert!(map.FindKey(0).is_err());
    assert!(map.FindFromIndex(13).is_err());
    let foreign = make_box(1.0, 1.0, 1.0);
    assert_eq!(map.FindIndex(&foreign), 0);
    assert!(map.FindFromKey(&foreign).is_err());

    let mut unique = top_tools::new_indexed_data_map_of_shape_list_of_shape();
    TopExp::MapShapesAndUniqueAncestors(
        &solid,
        TopAbs_ShapeEnum::TopAbs_VERTEX,
        TopAbs_ShapeEnum::TopAbs_EDGE,
        unique.pin_mut(),
        false,
    )
    .unwrap();
    assert_eq!(unique.Extent(), 8);
    assert_eq!(unique.FindFromIndex(1).unwrap().Size(), 3);

    let mut indexed = top_tools::new_indexed_map_of_shape();
    TopExp::MapShapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE, indexed.pin_mut()).unwrap();
    assert_eq!(indexed.Extent(), 6);
    assert!(indexed.FindKey(7).is_err());
}

#[test]
fn shape_lists_and_sequences() {
    let solid = make_box(1.0, 1.0, 1.0);
    let mut list = top_tools::new_list_of_shape();
    for face in subshapes(&solid, TopAbs_ShapeEnum::TopAbs_FACE) {
        let appended = list.pin_mut().Append(&face);
        assert!(appended.IsSame(&face));
    }
    assert_eq!(list.Size(), 6);
    assert_eq!(topo_ds::shape_list_to_vector(&list).len(), 6);

    let mut sequence = top_tools::new_Handle_TopTools_HSequenceOfShape();
    assert!(!sequence.IsNull());
    top_tools::TopTools_HSequenceOfShape_append(sequence.pin_mut(), &solid).unwrap();
    assert_eq!(top_tools::TopTools_HSequenceOfShape_length(&sequence).unwrap(), 1);
    assert!(top_tools::TopTools_HSequenceOfShape_value(&sequence, 1).unwrap().IsSame(&solid));
    assert!(top_tools::TopTools_HSequenceOfShape_value(&sequence, 2).is_err());
    assert_eq!(top_tools::HandleTopTools_HSequenceOfShape_Get(&sequence).unwrap().Length(), 1);
}

#[test]
fn locations_move_shapes() {
    let solid = make_box(1.0, 1.0, 1.0);
    let mut transform = gp::new_transform();
    transform.pin_mut().set_translation_vec(&gp::new_vec(10.0, 0.0, 0.0));
    let location = top_loc::Location_from_transform(&transform);
    assert_close(
        top_loc::TopLoc_Location_Transformation(&location).Value(1, 4).unwrap(),
        10.0,
        EPS,
    );
    assert_eq!(
        top_loc::TopLoc_Location_Transformation(&top_loc::Location_new()).Value(1, 4).unwrap(),
        0.0
    );

    let mut moved = topo_ds::TopoDS_Shape_to_owned(&solid);
    moved.pin_mut().translate(&location, true).unwrap();
    moved.pin_mut().translate(&location, true).unwrap();
    let mut placed = topo_ds::TopoDS_Shape_to_owned(&solid);
    placed.pin_mut().set_global_translation(&location, true).unwrap();

    let center_x = |shape: &topo_ds::TopoDS_Shape| {
        let mut props = scratchcad_occt_sys::g_prop::GProps_new();
        scratchcad_occt_sys::b_rep_g_prop::BRepGProp::VolumeProperties(
            shape,
            props.pin_mut(),
            false,
            false,
            false,
        )
        .unwrap();
        scratchcad_occt_sys::g_prop::GProp_GProps_CentreOfMass(&props).X()
    };
    assert_close(center_x(&solid), 0.5, EPS);
    assert_close(center_x(&moved), 20.5, EPS);
    assert_close(center_x(&placed), 10.5, EPS);
    // A different location makes it a different shape.
    assert!(!moved.IsSame(&solid));
}
