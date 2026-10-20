// SRD-05VDC relay: 19 x 15.5 x 15.4 mm housing with label recess and 5 pins (coil, COM, NO, NC)
let length = 19.0; // [15.0, 25.0] Length (mm)
let width = 15.5; // [10.0, 20.0] Width (mm)
let height = 15.4; // [10.0, 20.0] Height (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]).chamfer(0.4, "|Z or >Z");
body = body - box_centered(length - 3.0, width - 3.0, 0.3).translate([0, 0, height - 0.15 + 0.01]);
let pins = [];
for p in [[-7.0, -6.0], [-7.0, 6.0], [-5.0, 0.0], [7.0, -6.0], [7.0, 6.0]] { pins.push(box_centered(0.8, 0.5, 3.5).translate([p[0], p[1], -1.75])); }
fuse_all([body] + pins)
