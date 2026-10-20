// Bed rail hook bracket pair half: 150 x 38 mm plate 3 mm with 2 hooks 12 mm and 4 x 5 mm countersunk holes
let height = 150.0; // [100.0, 200.0] Plate height (mm)
let width = 38.0; // [25.0, 50.0] Plate width (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let plate = box_from_corners([0, 0, 0], [width, t, height]);
let hooks = [];
for z in [height * 0.25, height * 0.7] {
    hooks.push(polygon([[width / 2.0 - 6.0, z], [width / 2.0 + 6.0, z], [width / 2.0 + 6.0, z + 14.0], [width / 2.0 - 6.0, z + 20.0]]).to_face().extrude([0, 0, 6.0]).rotate_x(90.0).translate([0, t + 6.0 - 0.01, 0]));
}
let holes = [];
for z in [12.0, height * 0.5, height - 12.0] { holes.push(cylinder([width / 2.0, -1, z], "Y", 2.5, t + 2.0)); }
plate - compound(holes) + fuse_all(hooks).translate([0, 0, 0])
