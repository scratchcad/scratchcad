// Scaffold swivel coupler half for 48.3 mm tube: 2.5 mm pressed body, hinged cap, M14 T-bolt boss
let tube = 48.3; // [42.0, 60.3] Tube diameter (mm)
let r = tube / 2.0;
let body = (cylinder([0, -25.0, 0], "Y", r + 3.0, 50.0) - cylinder([0, -26.0, 0], "Y", r, 52.0)) & box_centered(2.0 * r + 30.0, 52.0, r + 6.0).translate([0, 0, -(r + 6.0) / 2.0]);
let hinge = cylinder([-r - 6.0, -25.0, 0], "Y", 5.0, 50.0) - cylinder([-r - 7.0, -26.0, 0], "Y", 2.5, 52.0);
let boss = box_from_corners([r + 1.0, -12.0, -10.0], [r + 16.0, 12.0, 0]) - cylinder([r + 8.5, 0, -11.0], "Z", 7.5, 12.0);
fuse_all([body, hinge, boss])
