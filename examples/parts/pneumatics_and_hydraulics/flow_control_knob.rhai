// Flow control needle valve knob: 18 mm knurled knob 10 mm tall, M5 lock nut recess, 3 mm D-shaft
let diameter = 18.0; // [12.0, 30.0] Knob diameter (mm)
let height = 10.0; // [6.0, 16.0] Height (mm)
let shaft = 3.0; // [2.0, 6.0] Shaft diameter (mm)
let knob = cylinder(diameter / 2.0, height);
let k = knob.fillet(1.0, knob.edges(">Z"));
let ribs = [];
for i in 0..24 { ribs.push(cylinder([diameter / 2.0 + 0.3, 0, -1], "Z", 0.7, height - 1.5).rotate_z(i.to_float() * 15.0)); }
let d = cylinder([0, 0, -1], "Z", shaft / 2.0, height - 2.0) & box_from_corners([-shaft, -shaft, -2], [shaft / 2.0 - 0.4, shaft, height]);
k - compound(ribs) - d - cylinder([0, 0, -1], "Z", 4.6, 3.0)
