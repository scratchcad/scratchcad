// Nano SIM card: 12.3 x 8.8 x 0.67 mm with the cut corner and 6 gold contact pads
let length = 12.3; // [12.3, 25.0] Length (mm)
let width = 8.8; // [8.8, 15.0] Width (mm)
let thickness = 0.67; // [0.67, 0.76] Thickness (mm)
let card = polygon([[0, 0], [length, 0], [length, width], [1.65, width], [0, width - 1.65]]).to_face().extrude(thickness).fillet(0.3, "|Z and (>X or <Y)");
let pads = [];
for col in 0..2 { for row in 0..3 { pads.push(box_from_corners([2.5 + col.to_float() * 5.08, 1.2 + row.to_float() * 2.54, thickness - 0.03], [2.5 + col.to_float() * 5.08 + 3.0, 1.2 + row.to_float() * 2.54 + 1.8, thickness + 1.0])); } }
card - compound(pads)
