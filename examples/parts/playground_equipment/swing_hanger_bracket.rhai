// Swing hanger bracket for a 100 x 100 mm beam: U-strap 100.5 mm inside, 5 mm steel, 50 mm wide, 60 mm legs with two 10.5 mm bolt holes each and a 12 mm shackle eye 25 mm below the beam
let beam = 100.5; // [70.0, 150.0] Beam width (mm)
let width = 50.0; // [35.0, 70.0] Strap width (mm)
const t = 5.0;
let u = box_from_corners([-beam / 2.0 - t, 0, -t], [beam / 2.0 + t, width, 60.0]) - box_from_corners([-beam / 2.0, -1.0, 0], [beam / 2.0, width + 1.0, 61.0]);
let lug = box_from_corners([-8.0, width / 2.0 - t / 2.0, -t - 25.0], [8.0, width / 2.0 + t / 2.0, -t + 0.01]) + cylinder([0, width / 2.0 - t / 2.0, -t - 25.0], "Y", 8.0, t);
let holes = [cylinder([0, width / 2.0 - t, -t - 25.0], "Y", 6.0, 2.0 * t)];
for z in [20.0, 45.0] { holes.push(cylinder([-beam, width / 2.0, z], "X", 5.25, 2.0 * beam)); }
u + lug - fuse_all(holes)
