// Rebar mushroom safety cap: 70 mm square-ish cap 8 mm thick with 6 mm corner radii over a 30 mm socket 35 mm deep for 10-16 mm bars, with 4 internal grip fins
let cap = 70.0; // [50.0, 100.0] Cap size (mm)
let bar = 16.0; // [10.0, 25.0] Largest bar diameter (mm)
const t = 8.0;
let c = box_centered(cap, cap, t).translate([0, 0, 35.0 + t / 2.0]);
let c = c.fillet(6.0, c.edges("|Z"));
let sock = cylinder([0, 0, 0], "Z", bar / 2.0 + 4.0, 35.01) - cylinder([0, 0, -1.0], "Z", bar / 2.0 + 1.0, 36.0);
let fins = [];
for i in 0..4 { fins.push(box_centered(2.0, 3.0, 25.0).translate([bar / 2.0 + 0.6, 0, 12.5]).rotate_z(i.to_float() * 90.0)); }
c + sock + fuse_all(fins)
