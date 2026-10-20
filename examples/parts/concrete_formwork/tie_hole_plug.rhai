// Formwork tie hole plug: tapered 26 to 22 mm plug 25 mm long matching a tie cone hole, with 3 grip rings and a 30 mm flush cap 2 mm thick
let big = 26.0; // [20.0, 32.0] Plug large end (mm)
let length = 25.0; // [15.0, 40.0] Plug length (mm)
let p = cone(big / 2.0 - 2.0, big / 2.0, length) + cylinder([0, 0, length - 0.01], "Z", big / 2.0 + 2.0, 2.0);
let rings = [];
for i in 0..3 { rings.push(cone(big / 2.0 - 2.0 + i.to_float() * 0.5, big / 2.0 - 1.0 + i.to_float() * 0.5 + 0.5, 1.5).translate([0, 0, 4.0 + i.to_float() * 6.0])); }
p + fuse_all(rings)
