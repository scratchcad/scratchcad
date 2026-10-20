// 25 mm h6 drive shaft, 120 mm long, with an 8 x 7 DIN 6885 keyway 4.0 mm deep and 40 mm long near one end, 1 mm end chamfers
let shaft_diameter = 25.0; // [10.0, 60.0] Shaft diameter (mm)
let shaft_length = 120.0; // [50.0, 300.0] Shaft length (mm)
// # Keyway
let key_width = 8.0; // [3.0, 18.0] Keyway width (mm)
let keyway_depth = 4.0; // [1.5, 7.5] Keyway depth in the shaft (mm)
let keyway_length = 40.0; // [15.0, 100.0] Keyway length (mm)
let keyway_inset = 8.0; // [3.0, 30.0] Keyway start from the shaft end (mm)
let r = shaft_diameter / 2.0;
let shaft = cylinder(r, shaft_length).chamfer(1.0, "%CIRCLE");
let w = min(key_width, shaft_diameter * 0.4);
let d = min(keyway_depth, r * 0.4);
let half = (keyway_length - w) / 2.0;
let zc = shaft_length - keyway_inset - keyway_length / 2.0;
let slot = sketch("YZ").move_to(-w / 2.0, -half).vline(2.0 * half).arc_to(0.0, half + w / 2.0, w / 2.0, half).vline(-2.0 * half).arc_to(0.0, -half - w / 2.0, -w / 2.0, -half).close();
let cutter = slot.to_face().extrude([r, 0, 0]).translate([r - d, 0, zc]);
shaft - cutter
