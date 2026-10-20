// Moss pole connector: joins two 30 mm moss pole sections, 34 mm sleeve 60 mm long with 2 mm walls, a centre stop ring and 6 water holes 4 mm
let pole = 30.0; // [20.0, 40.0] Pole core diameter (mm)
let length = 60.0; // [40.0, 90.0] Sleeve length (mm)
const wall = 2.0;
let r = pole / 2.0 + 0.3;
let s = cylinder([0, 0, 0], "Z", r + wall, length) - cylinder([0, 0, -1.0], "Z", r, length + 2.0);
let stop = cylinder([0, 0, length / 2.0 - 1.0], "Z", r + 0.01, 2.0) - cylinder([0, 0, length / 2.0 - 2.0], "Z", r - 3.0, 4.0);
let holes = [];
for i in 0..3 { holes.push(cylinder([-r - 5.0, 0, length * 0.25], "X", 2.0, 2.0 * r + 10.0).rotate_z(i.to_float() * 60.0)); }
s + stop - fuse_all(holes)
