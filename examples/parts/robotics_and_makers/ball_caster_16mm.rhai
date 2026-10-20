// Ball caster for small robots: 5/8 in (15.9 mm) steel ball in a 22 mm housing, 3 point contacts, 30 mm two-hole flange with M3 holes 24 mm apart, 20 mm total height
let ball_d = 15.9; // [8.0, 25.4] Ball diameter (mm)
let height = 20.0; // [12.0, 35.0] Overall height to the floor (mm)
let hole_spacing = 24.0; // [16.0, 40.0] Mounting hole spacing (mm)
let rb = ball_d / 2.0;
let hr = rb + 3.0;
let zc = rb;
let top = max(height, ball_d + 2.0);
let housing = cylinder([0, 0, zc - rb * 0.55], "Z", hr, top - (zc - rb * 0.55)).chamfer(1.0, "<Z");
let hs = max(hole_spacing, 2.0 * hr + 4.0);
let fl = (box_centered(hs, 2.0 * hr, 3.0) + cylinder([-hs / 2.0, 0, -1.5], "Z", hr, 3.0) + cylinder([hs / 2.0, 0, -1.5], "Z", hr * 0.6, 3.0)).translate([0, 0, top - 1.5]);
fl = (box_centered(hs, 8.0, 3.0) + cylinder([-hs / 2.0, 0, -1.5], "Z", 4.0, 3.0) + cylinder([hs / 2.0, 0, -1.5], "Z", 4.0, 3.0)).translate([0, 0, top - 1.5]);
let h = housing + fl;
h -= sphere([0, 0, zc], rb + 0.3);
h -= cylinder([0, 0, zc - rb], "Z", rb * 0.85, rb * 0.6) & sphere([0, 0, zc], rb + 0.3);
h -= cylinder([-hs / 2.0, 0, top - 5.0], "Z", 1.6, 10.0) + cylinder([hs / 2.0, 0, top - 5.0], "Z", 1.6, 10.0);
compound([h, sphere([0, 0, zc], rb)])
