// Furniture cam lock: 15 mm housing 12.5 mm tall, cross drive recess, side entry slot into a 9 mm bolt-head pocket
let d = 15.0; // [12.0, 25.0] Diameter (mm)
let h = 12.5; // [10.0, 16.0] Height (mm)
let cam = cylinder(d / 2.0, h).chamfer(0.5, ">Z");
cam -= box_centered(1.2, 8.0, 4.0).translate([0, 0, h]) + box_centered(8.0, 1.2, 4.0).translate([0, 0, h]);
cam -= cylinder([0, 0, 3.0], "Z", 4.5, 6.0);
cam - box_from_corners([2.0, -2.5, 3.0], [d, 2.5, 9.0])
