// Cabinet door bumper: 10 mm flat bumper pad 3 mm tall with a chamfered edge on a 5 mm push-in stem 6 mm long with 2 barbs, for a 5 mm drilled hole
let pad = 10.0; // [8.0, 16.0] Pad diameter (mm)
let stem = 5.0; // [3.0, 8.0] Stem diameter (mm)
let p = cylinder([0, 0, 0], "Z", pad / 2.0, 3.0);
let p = p.chamfer(0.8, p.edges(">Z"));
let s = cylinder([0, 0, -6.0], "Z", stem / 2.0 - 0.2, 6.01);
let barbs = cone(stem / 2.0 + 0.3, stem / 2.0 - 0.2, 1.5).translate([0, 0, -5.0]) + cone(stem / 2.0 + 0.3, stem / 2.0 - 0.2, 1.5).translate([0, 0, -2.5]);
p + s + barbs
