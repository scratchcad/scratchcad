// T-square head for a 600 mm blade: 300 x 40 x 12 mm head, 50 mm blade socket 3 mm deep with 3 screw holes
let length = 300.0; // [200.0, 400.0] Head length (mm)
let width = 40.0; // [30.0, 60.0] Head width (mm)
let thickness = 12.0; // [8.0, 20.0] Head thickness (mm)
let blade_w = 50.0; // [30.0, 80.0] Blade width (mm)
let head = box_centered(width, length, thickness).translate([0, 0, thickness / 2.0]);
let h = head.fillet(3.0, head.edges("|X"));
let pocket = box_from_corners([0, -blade_w / 2.0, thickness - 3.0], [width / 2.0 + 1.0, blade_w / 2.0, thickness + 1.0]);
let holes = [];
for y in [-15.0, 0.0, 15.0] { holes.push(cylinder([10.0, y, -1], "Z", 2.0, thickness + 2.0)); }
h - pocket - compound(holes)
