// Fluted beech dowel pin 8 x 40 mm: 0.8 mm end chamfers, six straight glue flutes
let d = 8.0; // [5.0, 12.0] Diameter (mm)
let len = 40.0; // [20.0, 80.0] Length (mm)
let r = d / 2.0;
let dowel = cylinder(r, len).chamfer(0.8, "%CIRCLE");
let flutes = [];
for k in 0..6 { flutes.push(cylinder([r + 0.1, 0, -1], "Z", 0.5, len + 2.0).rotate("Z", k.to_float() * 60.0)); }
dowel - fuse_all(flutes)
