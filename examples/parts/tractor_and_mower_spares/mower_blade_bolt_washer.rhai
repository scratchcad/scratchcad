// Mower blade bolt cup washer: 35 mm dished washer 4 mm, 11 mm bolt hole, 2 drive pins 5 mm on 22 mm centres
let d = 35.0; // [25.0, 50.0] Washer diameter (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let bolt = 11.0; // [8.0, 16.0] Bolt hole (mm)
let w = cylinder(d / 2.0, t) - sphere([0, 0, t + 40.0 - 1.5], 40.0);
let pins = cylinder([-11.0, 0, -5.0], "Z", 2.5, 5.01) + cylinder([11.0, 0, -5.0], "Z", 2.5, 5.01);
w + pins - cylinder([0, 0, -1], "Z", bolt / 2.0, t + 2.0)
