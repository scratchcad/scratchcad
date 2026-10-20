// T25 cell culture flask: 25 cm2 growth area, 95 x 60 x 25 mm body with 1.2 mm walls, canted 45 deg neck 21 mm OD with a vented cap
let len = 95.0; // [70.0, 150.0] Body length (mm)
let body = box_centered(len, 60.0, 25.0).translate([len / 2.0, 0, 12.5]).fillet(3.0, "|Z") - box_centered(len - 2.4, 57.6, 22.6).translate([len / 2.0, 0, 12.5]).fillet(2.0, "|Z");
let dir = [-0.7071, 0, 0.7071];
let neck = cylinder([2.0, 0, 12.5], dir, 10.5, 22.0) - cylinder([4.0, 0, 12.5], dir, 9.0, 24.0);
let cap = cylinder([-13.5, 0, 28.0], dir, 12.5, 14.0) - cylinder([-13.5, 0, 28.0], dir, 10.6, 12.0);
compound([body + neck - cylinder([5.0, 0, 12.5], dir, 9.0, 8.0), cap])
