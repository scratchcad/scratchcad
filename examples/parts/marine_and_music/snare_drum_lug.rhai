// Snare drum tube lug: 60 mm body with rounded ends, two 5 mm mounting bosses 52 mm apart, swivel nut insert 11 mm wide
let len = 60.0; // [40.0, 90.0] Lug length (mm)
let body = cylinder([0, 0, -len / 2.0 + 6.0], "Z", 6.0, len - 12.0) + sphere([0, 0, -len / 2.0 + 6.0], 6.0) + sphere([0, 0, len / 2.0 - 6.0], 6.0);
let bosses = [cylinder([0, -8.0, -26.0], "Y", 4.0, 3.0), cylinder([0, -8.0, 26.0], "Y", 4.0, 3.0)];
let lug = fuse_all([body] + bosses) - cylinder([0, 0, -len / 2.0 - 1.0], "Z", 2.5, 15.0) - box_centered(11.0, 14.0, 8.0).translate([0, 0, -len / 2.0 + 14.0]);
for z in [-26.0, 26.0] { lug -= cylinder([0, -9.0, z], "Y", 1.5, 6.0); }
lug
