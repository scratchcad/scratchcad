// Single-gang decorator wall plate: 70 x 115 x 6 mm with rounded front edges, 33.5 x 67 mm opening, two countersunk screw holes 96.8 mm apart
let w = 70.0; // [65.0, 80.0] Width (mm)
let h = 115.0; // [110.0, 130.0] Height (mm)
let plate = box_centered(w, h, 6.0).translate([0, 0, 3.0]).fillet(1.5, ">Z");
plate -= box_centered(w - 6.0, h - 6.0, 10.0).translate([0, 0, 0]);
plate -= box_centered(33.5, 67.0, 20.0);
for y in [-48.4, 48.4] { plate -= cylinder([y * 0.0, y, -1], "Z", 1.9, 10.0) + cone(1.9, 3.6, 1.0).translate([0, y, 5.01]); }
plate
