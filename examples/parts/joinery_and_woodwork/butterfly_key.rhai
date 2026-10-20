// Butterfly (bow-tie) key for slab cracks: 100 mm long, 50 mm wide wings, 20 mm waist, 12 mm thick, 8 degree draft
let length = 100.0; // [50.0, 200.0] Length (mm)
let wing = 50.0; // [25.0, 100.0] Wing width (mm)
let waist = 20.0; // [10.0, 40.0] Waist width (mm)
let t = 12.0; // [6.0, 25.0] Thickness (mm)
let k = loft([wire([polyline([[-length / 2.0, -wing / 2.0, 0], [0, -waist / 2.0, 0], [length / 2.0, -wing / 2.0, 0], [length / 2.0, wing / 2.0, 0], [0, waist / 2.0, 0], [-length / 2.0, wing / 2.0, 0], [-length / 2.0, -wing / 2.0, 0]])]), wire([polyline([[-length / 2.0 + 1.5, -wing / 2.0 + 1.5, t], [0, -waist / 2.0 + 1.5, t], [length / 2.0 - 1.5, -wing / 2.0 + 1.5, t], [length / 2.0 - 1.5, wing / 2.0 - 1.5, t], [0, waist / 2.0 - 1.5, t], [-length / 2.0 + 1.5, wing / 2.0 - 1.5, t], [-length / 2.0 + 1.5, -wing / 2.0 + 1.5, t]])])], true);
k
