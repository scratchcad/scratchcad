// JIC -08 dust cap: plastic push-on cap for a 3/4-16 UNF male JIC end, 21 mm ID skirt 14 mm deep with 1.5 mm walls, 8 grip ribs and a 37 degree seal-face cone inside the top
let thread_d = 19.05; // [12.7, 28.6] Male thread_d OD (mm)
let depth = 14.0; // [10.0, 20.0] Skirt depth (mm)
const wall = 1.5;
let r = thread_d / 2.0 + 0.6;
let c = cylinder([0, 0, 0], "Z", r + wall, depth + wall) - cylinder([0, 0, -1.0], "Z", r, depth + 1.0);
let ribs = [];
for i in 0..8 { ribs.push(box_centered(1.2, 1.2, depth).translate([r + wall, 0, depth / 2.0 + wall]).rotate_z(i.to_float() * 45.0)); }
let seat = cone(r * 0.5, r * 0.85, 3.0).rotate_x(180.0).translate([0, 0, depth + 0.01]);
c + fuse_all(ribs) + seat
