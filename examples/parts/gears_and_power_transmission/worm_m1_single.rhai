// Single-start worm, module 1 (axial pitch 3.14 mm), 12 mm pitch diameter, 30 mm long thread on a 6 mm shaft
let gear_module = 1.0; // [0.5, 2.0] Module (mm)
let pitch_d = 12.0; // [8.0, 30.0] Pitch diameter (mm)
let length = 30.0; // [10.0, 60.0] Thread length (mm)
let shaft_d = 6.0; // [3.0, 12.0] Shaft diameter (mm)
let pitch = gear_module * PI();
let r_root = pitch_d / 2.0 - 1.25 * gear_module;
let r_tip = pitch_d / 2.0 + gear_module;
let tan20 = (20.0 * PI() / 180.0).tan();
let half_root = pitch / 4.0 + 1.25 * gear_module * tan20;
let half_tip = pitch / 4.0 - gear_module * tan20;
let section = polygon([[r_root - 0.5, 0, -half_root], [r_root - 0.05, 0, -half_root], [r_tip, 0, -half_tip], [r_tip, 0, half_tip], [r_root - 0.05, 0, half_root], [r_root - 0.5, 0, half_root]]);
let turns = (length / pitch).ceiling().to_int() + 2;
let sections = [];
for i in 0..=(turns * 12) { let t = i.to_float() / 12.0; sections.push(section.rotate_z(t * 360.0).translate([0, 0, -pitch + t * pitch])); }
let core = cylinder([0, 0, -pitch * 2.0], "Z", r_root, (turns + 3).to_float() * pitch);
let worm = (core + loft(sections, true)) & cylinder(r_tip + 1.0, length);
worm + cylinder([0, 0, -15.0], "Z", shaft_d / 2.0, length + 30.0)
