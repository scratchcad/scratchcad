// microSD card: 11 x 15 x 1 mm with the stepped notch outline and 8 contact pads recessed 0.05 mm
let width = 11.0; // [11.0, 11.0] Width (mm)
let length = 15.0; // [15.0, 15.0] Length (mm)
let thickness = 1.0; // [0.7, 1.0] Thickness (mm)
let outline = polygon([[0, 0], [width, 0], [width, length], [1.4, length], [1.4, length - 6.4 + 1.0], [0.6, length - 6.4], [0.6, 6.9], [0, 6.0]]);
let card = outline.to_face().extrude(thickness).fillet(0.3, "|Z and >Y");
let pads = [];
for i in 0..8 { pads.push(box_from_corners([1.6 + i.to_float() * 1.1, 0.5, -0.1], [2.4 + i.to_float() * 1.1, 4.0, 0.05])); }
card - compound(pads)
