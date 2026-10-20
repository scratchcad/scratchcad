// Round RC engine cowling: 90 mm OD, 1.5 mm shell 70 mm long, 70 mm front opening, eight cooling slots, four M2 mounting holes
let od = 90.0; // [60.0, 140.0] Outer diameter (mm)
let len = 70.0; // [40.0, 120.0] Length (mm)
let r = od / 2.0;
let cowl = cylinder(r, len) - cylinder([0, 0, -1], "Z", r - 1.5, len - 1.0);
cowl = cowl.fillet(6.0, ">Z") - cylinder([0, 0, len - 5.0], "Z", r - 10.0, 10.0);
let cuts = [];
for k in 0..8 { cuts.push(box_centered(10.0, 6.0, 20.0).translate([r, 0, len * 0.45]).rotate("Z", k.to_float() * 45.0 + 22.5)); }
for k in 0..4 { cuts.push(cylinder([r - 3.0, 0, 6.0], "X", 1.0, 6.0).rotate("Z", k.to_float() * 90.0)); }
cowl - fuse_all(cuts)
