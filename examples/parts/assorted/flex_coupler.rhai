// 5 mm to 8 mm helical-beam flexible coupler
let diameter = 19.0; // [12.0, 30.0] Outside diameter (mm)
let length = 25.0; // [18.0, 40.0] Length (mm)
let bore_a = 5.0; // [3.0, 10.0] Bore at the bottom (mm)
let bore_b = 8.0; // [3.0, 12.0] Bore at the top (mm)
let slot_length = 9.0; // [4.0, 15.0] Helical slot length (mm)
let slot_turns = 3; // [1, 6] Turns of the helical slot
let body = cylinder(diameter / 2.0, length);
body -= cylinder([0, 0, -1], "Z", bore_a / 2.0, length / 2.0 + 1.0);
body -= cylinder([0, 0, length / 2.0 - 0.01], "Z", bore_b / 2.0, length / 2.0 + 1.0);
// helical slot: a thin blade lofted along a helix through the wall
let z0 = (length - slot_length) / 2.0;
let pitch = slot_length / slot_turns.to_float();
let blade = polygon([[bore_b / 2.0 - 1.5, 0, -0.35], [diameter / 2.0 + 1.0, 0, -0.35], [diameter / 2.0 + 1.0, 0, 0.35], [bore_b / 2.0 - 1.5, 0, 0.35]]);
let sections = [];
let n = 12;
for i in 0..=(slot_turns * n) {
    let t = i.to_float() / n.to_float();
    sections.push(blade.rotate_z(t * 360.0).translate([0, 0, z0 + t * pitch]));
}
body -= loft(sections, true);
// set screws: two M4 holes in each half, 90 degrees apart
for z in [length * 0.15, length * 0.85] { for a in [0, 90] {
    body -= cylinder([0, 0, z], "X", 1.7, diameter).rotate_z(a);
} }
body
