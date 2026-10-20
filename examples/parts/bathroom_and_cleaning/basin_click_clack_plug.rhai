// Basin click-clack (pop-up) plug for a 1-1/4 in waste: 63 mm domed head 6 mm, 56 mm seal seat, 8 mm stem 45 mm long with an M5 tapped hole for the spring cartridge
let head_d = 63.0; // [50.0, 70.0] Head diameter (mm)
let head_h = 6.0; // [4.0, 9.0] Head height (mm)
let seat_d = 56.0; // [40.0, 62.0] Seal seat diameter (mm)
let stem_l = 45.0; // [30.0, 60.0] Stem length (mm)
let stem_d = 8.0; // [6.0, 12.0] Stem diameter (mm)
let r = head_d / 2.0;
const rise = 3.0;
let sr = (r * r + rise * rise) / (2.0 * rise);
let head = sphere([0, 0, head_h - sr], sr) & cylinder(r, head_h);
let seat = cylinder([0, 0, -3.0], "Z", seat_d / 2.0, 3.01) - cylinder([0, 0, -4.0], "Z", seat_d / 2.0 - 4.0, 2.5);
let stem = cylinder([0, 0, -stem_l], "Z", stem_d / 2.0, stem_l);
let fins = [];
for i in 0..3 { fins.push(box_from_corners([0, -0.75, -stem_l + 8.0], [stem_d / 2.0 + 3.0, 0.75, -1.5]).rotate_z(i.to_float() * 120.0)); }
head + seat + stem + fuse_all(fins) - cylinder([0, 0, -stem_l - 1.0], "Z", 2.1, 13.0)
