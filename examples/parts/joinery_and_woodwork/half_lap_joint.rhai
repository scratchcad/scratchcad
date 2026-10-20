// Cross half-lap joint: two 45 x 20 mm battens 150 mm long crossing at their middles, 10 mm deep laps, assembled (two solids)
let length = 150.0; // [80.0, 300.0] Batten length (mm)
let width = 45.0; // [20.0, 90.0] Batten width (mm)
let t = 20.0; // [10.0, 45.0] Batten thickness (mm)
let a = box_centered(length, width, t).translate([0, 0, t / 2.0]) - box_centered(width, width + 2.0, t).translate([0, 0, t]);
let b = box_centered(width, length, t).translate([0, 0, t / 2.0]) - box_centered(width + 2.0, width, t).translate([0, 0, 0]);
compound([a, b])
