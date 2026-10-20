// HC-49/US crystal: 11 x 4.65 x 3.5 mm can with rounded ends, 4.88 mm lead spacing
let length = 11.0; // [10.0, 12.0] Can length (mm)
let width = 4.65; // [4.0, 5.0] Can width (mm)
let height = 3.5; // [3.0, 13.5] Can height (mm)
let can = (box_centered(length - width, width, height) + cylinder([-(length - width) / 2.0, 0, -height / 2.0], "Z", width / 2.0, height) + cylinder([(length - width) / 2.0, 0, -height / 2.0], "Z", width / 2.0, height)).translate([0, 0, height / 2.0 + 0.4]);
let base = (box_centered(length - width + 0.6, width + 0.6, 0.4) + cylinder([-(length - width) / 2.0, 0, -0.2], "Z", width / 2.0 + 0.3, 0.4) + cylinder([(length - width) / 2.0, 0, -0.2], "Z", width / 2.0 + 0.3, 0.4)).translate([0, 0, 0.2]);
can + base + cylinder([-2.44, 0, -5.0], "Z", 0.22, 5.01) + cylinder([2.44, 0, -5.0], "Z", 0.22, 5.01)
