// Floor squeegee blade holder: 350 mm channel 12 x 16 mm, 3.2 mm slot 11 mm deep for the rubber blade, centre socket for a 22 mm broom handle tilted 15 degrees, 5 retaining pin holes
let length = 350.0; // [200.0, 600.0] Holder length (mm)
let blade_t = 3.2; // [2.0, 6.0] Blade slot width (mm)
let slot_depth = 11.0; // [6.0, 14.0] Slot depth (mm)
let handle_d = 22.0; // [19.0, 28.0] Handle socket bore (mm)
let tilt = 15.0; // [0.0, 30.0] Handle tilt (degrees)
const w = 12.0;
const h = 16.0;
let bar = box_from_corners([-length / 2.0, -w / 2.0, 0], [length / 2.0, w / 2.0, h]);
let socket = cylinder([0, 0, h - 3.0], "Z", handle_d / 2.0 + 3.0, 40.0).rotate([0, 0, h], "X", -tilt);
let bore = cylinder([0, 0, h + 3.0], "Z", handle_d / 2.0, 40.0).rotate([0, 0, h], "X", -tilt);
let foot = box_from_corners([-handle_d / 2.0 - 3.0, -w / 2.0, 0], [handle_d / 2.0 + 3.0, w / 2.0, h + 4.0]);
let part = bar + foot + socket - bore - box_from_corners([-length / 2.0 - 1.0, -blade_t / 2.0, -1], [length / 2.0 + 1.0, blade_t / 2.0, slot_depth]);
let pins = [];
for i in 0..5 { pins.push(cylinder([(i.to_float() - 2.0) * length * 0.22, -w, slot_depth / 2.0], "Y", 1.6, 2.0 * w)); }
part - compound(pins)
