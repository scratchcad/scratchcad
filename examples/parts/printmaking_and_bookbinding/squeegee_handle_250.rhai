// Screen printing squeegee handle: 250 mm long, 35 mm wide grip with finger channel, 9.5 x 25 mm blade slot and 4 mm cross holes for retaining pins every 60 mm
let length = 250.0; // [150.0, 400.0] Handle length (mm)
let blade_t = 9.5; // [6.0, 10.0] Blade thickness (mm)
const height = 60.0;
const width = 35.0;
let profile = polygon([[0, -blade_t / 2.0 - 4.0, 0], [0, blade_t / 2.0 + 4.0, 0], [0, blade_t / 2.0 + 4.0, 30.0], [0, width / 2.0, 45.0], [0, width / 2.0, height], [0, -width / 2.0, height], [0, -width / 2.0, 45.0], [0, -blade_t / 2.0 - 4.0, 30.0]]);
let h = face(profile).extrude([length, 0, 0]);
let slot = box_from_corners([-1.0, -blade_t / 2.0, -1.0], [length + 1.0, blade_t / 2.0, 25.0]);
let channel = cylinder([-1.0, width / 2.0 + 3.0, 52.0], "X", 5.0, length + 2.0) + cylinder([-1.0, -width / 2.0 - 3.0, 52.0], "X", 5.0, length + 2.0);
let pins = [];
let n = (length / 60.0).to_int();
for i in 0..n { pins.push(cylinder([30.0 + i.to_float() * 60.0, -width, 12.0], "Y", 2.0, 2.0 * width)); }
h - slot - channel - fuse_all(pins)
