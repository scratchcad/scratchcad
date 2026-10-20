// Spade clock minute hand: 95 mm, 0.8 mm thick, 3 mm round bush hole, spade 8 mm, counterweight tail 20 mm
let length = 95.0; // [50.0, 150.0] Hand length (mm)
let t = 0.8; // [0.5, 1.5] Thickness (mm)
let spade = 8.0; // [5.0, 14.0] Spade width (mm)
let shaft = polygon([[0, -1.5], [length * 0.8, -0.8], [length * 0.8, 0.8], [0, 1.5]]).to_face().extrude([0, 0, t]);
let sp = polygon([[length * 0.75, 0], [length * 0.85, -spade / 2.0], [length, 0], [length * 0.85, spade / 2.0]]).to_face().extrude([0, 0, t]);
let tail = polygon([[0, -1.5], [-20.0, -4.0], [-22.0, 0], [-20.0, 4.0], [0, 1.5]]).to_face().extrude([0, 0, t]);
let hub = cylinder(4.0, t);
shaft + sp + tail + hub - cylinder([0, 0, -1], "Z", 1.5, t + 2.0)
