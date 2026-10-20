// 130-size DC motor: 20 mm can with two flats 15 mm apart, 25 mm long, 2 mm shaft 8 mm long, end bell with tabs
let diameter = 20.0; // [15.0, 30.0] Can diameter (mm)
let flats = 15.0; // [12.0, 25.0] Across flats (mm)
let length = 25.0; // [18.0, 40.0] Can length (mm)
let shaft_d = 2.0; // [1.5, 3.0] Shaft diameter (mm)
let can = cylinder(diameter / 2.0, length) & box_centered(diameter + 2.0, flats, length * 3.0);
let bell = (cylinder([0, 0, -4.0], "Z", diameter / 2.0 - 0.5, 4.01) & box_centered(diameter, flats, 20.0)) - cylinder([0, 0, -5], "Z", 3.0, 2.0);
let boss = cylinder([0, 0, length - 0.01], "Z", 3.0, 1.5);
let shaft = cylinder([0, 0, length], "Z", shaft_d / 2.0, 8.0 + 1.5);
let tabs = box_centered(2.0, 0.3, 4.0).translate([-5.0, 0, -5.5]) + box_centered(2.0, 0.3, 4.0).translate([5.0, 0, -5.5]);
fuse_all([can, bell, boss, shaft, tabs])
