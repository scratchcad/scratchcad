// Enlarger lens board: 100 x 100 x 4 mm board with a 39 mm hole for an M39 enlarging lens, a 1.5 mm locating rebate 2 mm wide around the edge and a 15 mm grip tab
let size = 100.0; // [80.0, 150.0] Board size (mm)
let hole = 39.0; // [25.0, 52.0] Lens mount hole (mm)
const t = 4.0;
let b = box_centered(size, size, t).translate([0, 0, t / 2.0]);
let rebate = box_centered(size + 2.0, size + 2.0, 1.5).translate([0, 0, 0.75 - 0.01]) - box_centered(size - 4.0, size - 4.0, 4.0).translate([0, 0, 0]);
let tab = box_from_corners([-10.0, size / 2.0 - 0.01, 0], [10.0, size / 2.0 + 15.0, t]);
b - rebate + tab - cylinder([0, 0, -1.0], "Z", hole / 2.0, t + 2.0)
