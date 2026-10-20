// Poker chip: 39 mm diameter 3.3 mm thick, raised edge ring, centre inlay recess and twelve edge spots
let d = 39.0; // [30.0, 45.0] Diameter (mm)
let r = d / 2.0;
let chip = cylinder(r, 3.3).fillet(0.5, "%CIRCLE") - cylinder([0, 0, 3.0], "Z", r - 3.0, 1.0) - cylinder([0, 0, -0.7], "Z", r - 3.0, 1.0);
let spots = [];
for k in 0..12 { spots.push(box_centered(3.0, 4.0, 4.5).translate([r, 0, 1.65]).rotate("Z", k.to_float() * 30.0)); }
chip - fuse_all(spots) + cylinder([0, 0, 0.3], "Z", r - 0.4, 2.7)
