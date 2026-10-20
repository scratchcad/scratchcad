// Enlarger 35 mm negative carrier half: 130 x 80 x 2 mm plate with a 36.5 x 24.5 mm gate, 1 mm film recess 36 mm wide along the strip, two 3 mm register pins and a 20 mm finger tab
let gate_w = 36.5; // [36.0, 38.0] Gate width (mm)
let gate_h = 24.5; // [24.0, 26.0] Gate height (mm)
const t = 2.0;
let p = box_centered(130.0, 80.0, t).translate([0, 0, t / 2.0]);
let p = p.fillet(4.0, p.edges("|Z"));
let tab = box_from_corners([65.0 - 0.01, -10.0, 0], [85.0, 10.0, t]);
let gate = box_centered(gate_w, gate_h, t + 2.0).translate([0, 0, t / 2.0]);
let recess = box_centered(132.0, 36.0, 1.0).translate([0, 0, t - 0.5 + 0.01]);
let pins = cylinder([-30.0, 22.0, t - 0.01], "Z", 1.5, 2.0) + cylinder([30.0, 22.0, t - 0.01], "Z", 1.5, 2.0);
p + tab - gate - recess + pins
