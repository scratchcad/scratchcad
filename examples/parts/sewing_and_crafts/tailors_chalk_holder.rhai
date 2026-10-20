// Tailor's chalk holder: 50 x 40 mm wedge for 45 x 45 x 5 mm chalk triangles, 9 mm thick, thumb grip
let width = 50.0; // [40.0, 70.0] Width (mm)
let depth = 40.0; // [30.0, 60.0] Depth (mm)
let thickness = 9.0; // [6.0, 14.0] Thickness (mm)
let chalk_t = 5.2; // [3.0, 8.0] Chalk slot (mm)
let tri = polygon([[0, 0, 0], [width, 0, 0], [width / 2.0, depth, 0]]).to_face().extrude([0, 0, thickness]);
let t = tri.fillet(3.0, tri.edges("|Z"));
let slot = polygon([[4.0, -1.0, 0], [width - 4.0, -1.0, 0], [width / 2.0, depth - 10.0, 0]]).to_face().extrude([0, 0, chalk_t]).translate([0, 0, (thickness - chalk_t) / 2.0]);
let grips = [];
for k in 0..5 { grips.push(box_from_corners([width / 2.0 - 8.0, depth - 18.0 + k.to_float() * 2.5, thickness - 0.6], [width / 2.0 + 8.0, depth - 17.0 + k.to_float() * 2.5, thickness + 1.0])); }
t - slot - compound(grips)
