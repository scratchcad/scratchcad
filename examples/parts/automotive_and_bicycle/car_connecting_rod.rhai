// Connecting rod, 144 mm centres: 53 mm big-end bore with split cap and two M9 bolts, 22 mm small-end bore with oil hole, I-beam shank
let c = 144.0; // [120.0, 160.0] Centre distance (mm)
let big = 53.0; // [45.0, 60.0] Big-end bore (mm)
let small = 22.0; // [18.0, 24.0] Small-end bore (mm)
let rb = big / 2.0;
let rod = cylinder([0, 0, -10.0], "Z", rb + 7.0, 20.0) + cylinder([c, 0, -10.0], "Z", small / 2.0 + 6.0, 20.0);
rod += polygon([[20, -14], [c - 12.0, -8], [c - 12.0, 8], [20, 14]]).to_face().extrude(16.0).translate([0, 0, -8.0]);
for s in [-1.0, 1.0] { rod += box_from_corners([-12.0, s * (rb + 1.0), -10.0], [12.0, s * (rb + 12.0), 10.0]); }
let pocket = polygon([[36, -9], [c - 24.0, -4.5], [c - 24.0, 4.5], [36, 9]]).to_face().extrude(4.0);
rod = rod - pocket.translate([0, 0, 5.0]) - pocket.translate([0, 0, -9.0]);
rod = rod - cylinder([0, 0, -11.0], "Z", rb, 22.0) - cylinder([c, 0, -11.0], "Z", small / 2.0, 22.0);
for s in [-1.0, 1.0] { rod -= cylinder([-14.0, s * (rb + 5.5), 0], "X", 4.5, 28.0); }
rod -= cylinder([c, 0, 0], "X", 2.0, 20.0);
rod - box_from_corners([-0.2, -40.0, -11.0], [0.2, 40.0, 11.0])
