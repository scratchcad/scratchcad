// Ratchet pawl for a 50 mm 24-tooth wheel: 30 mm long, 5 mm pivot, 6 mm thick, hooked tip
let length = 30.0; // [20.0, 50.0] Length (mm)
let pivot = 5.0; // [3.0, 8.0] Pivot hole (mm)
let thickness = 6.0; // [3.0, 12.0] Thickness (mm)
let body = polygon([[0, -5.0], [length - 6.0, -3.0], [length, -6.0], [length - 2.0, 2.0], [0, 5.0]]).to_face().extrude([0, 0, thickness]);
let boss = cylinder(6.0, thickness);
body + boss - cylinder([0, 0, -1], "Z", pivot / 2.0, thickness + 2.0) - cylinder([10.0, 9.0, -1], "Z", 1.0, thickness + 2.0)
