// Rotary dimmer knob: 35 mm, 18 mm tall, knurled skirt 40 ribs, 6 mm D-shaft with flat, 3 mm push travel recess
let diameter = 35.0; // [25.0, 45.0] Knob diameter (mm)
let height = 18.0; // [12.0, 25.0] Height (mm)
let shaft = 6.0; // [4.0, 8.0] Shaft diameter (mm)
let k = cylinder(diameter / 2.0, height);
let kk = k.chamfer(2.0, k.edges(">Z"));
let ribs = [];
for i in 0..40 { ribs.push(cylinder([diameter / 2.0 + 0.3, 0, -1], "Z", 0.8, height - 3.0).rotate_z(i.to_float() * 9.0)); }
let socket = cylinder([0, 0, -1], "Z", shaft / 2.0, 13.0) - box_from_corners([shaft / 2.0 - 1.5, -shaft, -2], [shaft, shaft, 13.0]);
let boss = cylinder([0, 0, 0], "Z", shaft / 2.0 + 2.5, height - 2.0);
let hollow = cylinder([0, 0, -1], "Z", diameter / 2.0 - 2.5, height - 4.0) - boss;
kk - compound(ribs) - hollow - socket
