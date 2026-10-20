// Centering ring: 29 mm motor mount tube (30.5 mm OD) in BT-60 (40.5 mm ID), 3 mm plywood, motor hook notch and two vent holes
let outer = 40.5; // [34.2, 100.0] Body tube inner diameter (mm)
let inner = 30.5; // [18.0, 33.0] Motor tube outer diameter (mm)
let t = 3.0; // [2.0, 6.0] Thickness (mm)
let ring = cylinder(outer / 2.0, t) - cylinder([0, 0, -1], "Z", inner / 2.0, t + 2.0);
ring -= box_from_corners([-1.5, inner / 2.0 - 1.0, -1], [1.5, inner / 2.0 + 1.5, t + 1.0]);
for a in [120.0, 240.0] { ring -= cylinder([(outer + inner) / 4.0, 0, -1], "Z", 1.0, t + 2.0).rotate("Z", a); }
ring
