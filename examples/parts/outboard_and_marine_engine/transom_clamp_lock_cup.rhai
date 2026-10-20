// Outboard transom clamp lock cup: 50 mm cup 40 mm tall with 4 mm walls that covers the clamp screw handle, a 16 mm slot 25 mm high in the side for the screw shaft, and two 4 mm ears 4 mm apart, standing 14 mm proud, with a 10 mm padlock hole through both, 1 mm chamfer on the rim
let cup_d = 50.0; // [40.0, 80.0] Cup diameter (mm)
let height = 40.0; // [30.0, 60.0] Cup height (mm)
let shackle_d = 10.0; // [6.0, 12.0] Padlock shackle hole (mm)
const wall = 4.0;
let r = cup_d / 2.0;
let cup = cylinder([0, 0, 0], "Z", r, height);
let cup = cup.chamfer(1.0, cup.edges("<Z"));
let ears = box_from_corners([-6.0, r - 2.0, height - 22.0], [6.0, r + 14.0, height]);
let body = cup + ears;
let cuts = [
    cylinder([0, 0, -1.0], "Z", r - wall, height - wall + 1.0),
    box_from_corners([-8.0, -r - 1.0, -1.0], [8.0, 0, 25.0]),
    cylinder([0, -r - 1.0, 25.0], "Y", 8.0, r + 1.0),
    cylinder([-7.0, r + 7.0, height - 11.0], "X", shackle_d / 2.0, 14.0),
    box_from_corners([-2.0, r + 0.5, -1.0], [2.0, r + 15.0, height + 1.0])
];
body - fuse_all(cuts)
