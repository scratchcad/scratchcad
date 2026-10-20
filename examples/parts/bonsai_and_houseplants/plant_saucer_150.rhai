// Plant pot saucer: 150 mm saucer 20 mm deep with a 3 mm floor, 2.5 mm walls flaring 10 degrees and six 3 mm raised ribs that lift the pot for drainage
let dia = 150.0; // [80.0, 300.0] Saucer base diameter (mm)
let depth = 20.0; // [12.0, 35.0] Saucer depth (mm)
const wall = 2.5;
let r = dia / 2.0;
let flare = depth * 0.176;
let s = cone(r, r + flare, depth) - cone(r - wall, r + flare - wall, depth).translate([0, 0, 3.0]);
let ribs = [];
for i in 0..6 { ribs.push(box_from_corners([10.0, -1.5, 2.99], [r - wall - 2.0, 1.5, 6.0]).rotate_z(i.to_float() * 60.0)); }
s + fuse_all(ribs)
