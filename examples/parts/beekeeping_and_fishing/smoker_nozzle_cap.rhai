// Bee smoker spout lid: 100 mm can lid with a 30 degree cone spout 25 mm to a 12 mm nozzle, 1 mm sheet
let lid = 100.0; // [80.0, 120.0] Can diameter (mm)
let skirt = 15.0; // [10.0, 25.0] Skirt depth (mm)
let t = 1.0; // [0.8, 2.0] Sheet thickness (mm)
let dome_h = 30.0; // [15.0, 50.0] Lid cone height (mm)
let outer = cylinder(lid / 2.0 + t, skirt) + cone(lid / 2.0 + t, 8.0, dome_h).translate([0, 0, skirt - 0.01]);
let inner = cylinder([0, 0, -1], "Z", lid / 2.0, skirt + 1.0) + cone(lid / 2.0, 8.0 - t, dome_h).translate([0, 0, skirt - 0.02]);
let spout = cylinder([0, 0, skirt + dome_h - 2.0], "Z", 8.0, 25.0).rotate([0, 0, skirt + dome_h - 2.0], "Y", 30.0) - cylinder([0, 0, skirt + dome_h - 3.0], "Z", 6.0, 30.0).rotate([0, 0, skirt + dome_h - 2.0], "Y", 30.0);
outer - inner + spout - cylinder([0, 0, skirt + dome_h - 10.0], "Z", 6.0, 10.0)
