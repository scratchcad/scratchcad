// Spin-on oil filter: 76 mm can 100 mm tall with 8 mm rounded end, 3/4-16 UNF centre thread, 8 inlet holes, 62/71 mm gasket
let dia = 76.0; // [65.0, 100.0] Can diameter (mm)
let h = 100.0; // [65.0, 140.0] Can height (mm)
let r = dia / 2.0;
let can = cylinder(r, h).fillet(8.0, ">Z");
let gasket = cylinder([0, 0, -6.0], "Z", r - 2.5, 6.5) - cylinder([0, 0, -7.0], "Z", r - 7.0, 8.0);
let f = can + gasket - cylinder([0, 0, -1], "Z", 9.5, 21.0);
for k in 0..8 { f -= cylinder([22.0, 0, -1], "Z", 4.0, 9.0).rotate("Z", k.to_float() * 45.0); }
f
