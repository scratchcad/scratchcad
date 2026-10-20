// Ratchet pawl for a 24-tooth 60 mm wheel: 35 mm lever on a 6 mm pivot with 12 mm boss, hooked 4 mm nose, spring hole 2.5 mm, 8 mm thick
let lever_length = 35.0; // [20.0, 80.0] Pivot to nose length (mm)
let pivot_hole = 6.0; // [3.0, 12.0] Pivot hole diameter (mm)
let boss_diameter = 12.0; // [7.0, 24.0] Pivot boss diameter (mm)
let thickness = 8.0; // [3.0, 25.0] Thickness (mm)
let nose = 4.0; // [1.5, 10.0] Nose depth (mm)
let rb = max(boss_diameter / 2.0, pivot_hole / 2.0 + 2.0);
let l = lever_length;
let body = polygon([[0, -rb], [l - 6.0, -rb * 0.7], [l, -rb * 0.7 - nose], [l + 2.0, -rb * 0.7 - nose + 0.5], [l, rb * 0.7], [0, rb]]).to_face().extrude(thickness);
let pawl = body + cylinder(rb, thickness);
pawl = pawl - cylinder([0, 0, -1], "Z", pivot_hole / 2.0, thickness + 2.0);
pawl - cylinder([l * 0.55, 0, -1], "Z", 1.25, thickness + 2.0)
