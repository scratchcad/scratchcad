// M2 snap clevis: 5 mm shank tapped 1.6 mm, 4.5 mm fork with a 1.6 mm slot 8 mm deep, integral 1.5 mm pin
let slot = 1.6; // [1.0, 3.0] Slot width (mm)
let body = cylinder(2.5, 6.5) + box_centered(4.5, 4.5, 10.0).translate([0, 0, 11.0]);
body -= box_centered(slot, 6.0, 8.5).translate([0, 0, 12.25]);
body -= cylinder([0, 0, -1], "Z", 0.8, 7.0);
body + cylinder([-2.25, 0, 13.5], "X", 0.75, 4.5)
