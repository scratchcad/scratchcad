// 1.25 inch eyepiece filter cell: 28.5 mm threaded spigot 5 mm long, 30.5 mm knurled ring, 26 mm glass seat 1.1 mm deep, 24 mm clear aperture
let spigot_d = 28.5; // [28.0, 28.8] Thread major diameter (mm)
let ring_d = 30.5; // [29.5, 32.0] Ring diameter (mm)
let clear = 24.0; // [20.0, 25.0] Clear aperture (mm)
const ring_h = 4.0;
let spigot = cylinder([0, 0, 0], "Z", spigot_d / 2.0, 5.01);
let ring = cylinder([0, 0, 5.0], "Z", ring_d / 2.0, ring_h);
let knurl = [];
for i in 0..24 { knurl.push(box_centered(1.0, 1.0, ring_h + 2.0).translate([ring_d / 2.0, 0, 5.0 + ring_h / 2.0]).rotate_z(i.to_float() * 15.0)); }
let cell = spigot + ring - fuse_all(knurl);
let seat = cylinder([0, 0, 5.0 + ring_h - 1.1], "Z", 13.0, 2.0);
let hole = cylinder([0, 0, -1.0], "Z", clear / 2.0, 12.0);
cell - seat - hole
