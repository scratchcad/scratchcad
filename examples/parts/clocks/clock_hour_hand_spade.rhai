// Spade clock hour hand: 70 mm long, 1 mm thick, 5.3 x 3 mm flat-sided hub hole, spade 12 mm wide
let length = 70.0; // [40.0, 120.0] Hand length (mm)
let t = 1.0; // [0.6, 2.0] Thickness (mm)
let spade = 12.0; // [8.0, 20.0] Spade width (mm)
let shaft = polygon([[0, -2.0], [length * 0.65, -1.0], [length * 0.65, 1.0], [0, 2.0]]).to_face().extrude([0, 0, t]);
let sp = polygon([[length * 0.6, 0], [length * 0.72, -spade / 2.0], [length * 0.85, -spade * 0.3], [length, 0], [length * 0.85, spade * 0.3], [length * 0.72, spade / 2.0]]).to_face().extrude([0, 0, t]);
let hub = cylinder(5.0, t) + cylinder([-8.0, 0, 0], "Z", 3.0, t) + box_from_corners([-8.0, -1.5, 0], [0, 1.5, t]);
let hole = cylinder([0, 0, -1], "Z", 2.65, t + 2.0) & box_centered(10.0, 3.0, t * 4.0);
shaft + sp + hub - hole - (cylinder([length * 0.75, 0, -1], "Z", 2.5, t + 2.0))
