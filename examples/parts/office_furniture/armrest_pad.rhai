// Office chair armrest pad: 250 x 90 mm, 25 mm thick with a 10 mm crowned top, 4 M6 inserts on 160 x 50 mm
let length = 250.0; // [200.0, 300.0] Pad length (mm)
let width = 90.0; // [60.0, 120.0] Pad width (mm)
let t = 25.0; // [15.0, 35.0] Thickness (mm)
let crown = 10.0; // [4.0, 15.0] Crown height (mm)
let pad = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = pad.fillet(width / 2.0 - 1.0, pad.edges("|Z"));
let rs = (width * width / 4.0 + crown * crown) / (2.0 * crown);
let shaped = p & cylinder([-length, 0, t - rs], "X", rs, length * 2.0);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 80.0, sy * 25.0, -1], "Z", 4.0, 12.0)); } }
shaped - compound(holes)
