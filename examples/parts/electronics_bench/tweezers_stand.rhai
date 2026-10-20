// Tweezer and tool stand: 60 x 40 x 40 mm angled block with 6 slots 3 x 12 mm and 4 round 8 mm holes
let width = 60.0; // [40.0, 100.0] Width (mm)
let depth = 40.0; // [30.0, 60.0] Depth (mm)
let height = 40.0; // [25.0, 60.0] Back height (mm)
let block = polygon([[0, 0], [depth, 0], [depth, height * 0.6], [0, height]]).to_face().extrude([0, 0, width]).rotate_x(90.0).translate([0, width, 0]);
let slots = [];
for i in 0..6 { slots.push(box_from_corners([6.0, 5.0 + i.to_float() * 8.5, 10.0], [18.0, 8.0 + i.to_float() * 8.5, height + 1.0])); }
let holes = [];
for i in 0..4 { holes.push(cylinder([depth - 9.0, 9.0 + i.to_float() * 14.0, 8.0], "Z", 4.0, height)); }
block - compound(slots) - compound(holes)
