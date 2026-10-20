// Window frame wedge / draught packer: 60 x 25 mm, tapering 6 to 1 mm, 3 break-off notches
let length = 60.0; // [40.0, 100.0] Wedge length (mm)
let width = 25.0; // [15.0, 40.0] Wedge width (mm)
let thick = 6.0; // [3.0, 12.0] Thick end (mm)
let w = polygon([[0, 0, 0], [length, 0, 0], [length, 0, 1.0], [0, 0, thick]]).to_face().extrude([0, width, 0]);
let notches = [];
for k in 1..4 { notches.push(box_from_corners([k.to_float() * length / 4.0 - 0.5, -1, -1], [k.to_float() * length / 4.0 + 0.5, width + 1.0, 0.6])); }
w - compound(notches)
