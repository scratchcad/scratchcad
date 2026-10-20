// Y-axis belt tensioner for 2020: 30 x 20 x 20 mm block sliding on the extrusion, M3 tension screw, 5 mm idler axle
let length = 30.0; // [20.0, 50.0] Length (mm)
let width = 26.0; // [22.0, 40.0] Width (mm)
let height = 20.0; // [15.0, 35.0] Height (mm)
let block = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(2.0, "|Z");
block = block - box_centered(length + 2.0, 20.4, 20.4).translate([0, 0, -10.2 + 6.0]);
block = block - box_centered(length * 0.6, 8.0, height).translate([0, 0, height - 2.0]);
block = block - cylinder([0, -width, height - 6.0], "Y", 2.6, width * 2.0);
block - cylinder([-length, 0, height - 3.0], "X", 1.6, length * 2.0)
