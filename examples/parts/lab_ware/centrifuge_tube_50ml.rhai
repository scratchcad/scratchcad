// 50 ml conical centrifuge tube: 29 mm OD, 115 mm long with a 20 mm conical tip, 1 mm wall, two thread ridges; screw cap beside it
let len = 115.0; // [80.0, 130.0] Tube length (mm)
let p = [[0, 0, 0], [3.0, 0, 0], [14.5, 0, 20.0], [14.5, 0, len], [13.5, 0, len], [13.5, 0, 20.5], [2.4, 0, 1.0], [0, 0, 1.0]];
let tube = polygon(p).to_face().revolve("Z", 360);
for z in [len - 9.0, len - 5.0] { tube += torus(14.5, 0.6).translate([0, 0, z]); }
let cap = cylinder(17.0, 14.0) - cylinder([0, 0, 2.0], "Z", 15.3, 14.0);
for k in 0..30 { cap -= cylinder([17.2, 0, 2.0], "Z", 0.6, 13.0).rotate("Z", k.to_float() * 12.0); }
compound([tube, cap.translate([40.0, 0, 0])])
