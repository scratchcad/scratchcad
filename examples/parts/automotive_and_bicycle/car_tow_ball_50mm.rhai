// 50 mm ISO tow ball on a 2-bolt flange: 110 x 60 x 15 mm flange with 17 mm holes 90 mm apart, collar, 28 mm neck
let ball = 50.0; // [48.0, 50.0] Ball diameter (mm)
let flange = box_centered(110.0, 60.0, 15.0).translate([0, 0, 7.5]).fillet(5.0, "|Z");
for x in [-45.0, 45.0] { flange -= cylinder([x, 0, -1], "Z", 8.5, 17.0); }
let collar = cylinder([0, 0, 15.0], "Z", 20.0, 5.0).chamfer(1.5, ">Z");
let neck = cylinder([0, 0, 19.0], "Z", 14.0, 41.0);
fuse_all([flange, collar, neck, sphere([0, 0, 75.0], ball / 2.0)])
