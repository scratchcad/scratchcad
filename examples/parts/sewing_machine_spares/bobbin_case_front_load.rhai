// Front-loading bobbin case for class 15 bobbins: 23.5 mm cup 12.5 mm deep inside 21.0 mm, 1 mm floor, 5.8 mm centre stud for the bobbin, 8 mm locating horn 6 mm long with a 4 mm bore behind, 1 mm thread slot 5 mm deep in the rim, a flat half the wall deep for the tension spring and a 6 x 3 mm locating finger on the rim
let cup_d = 23.5; // [21.5, 26.0] Cup diameter (mm)
let cup_depth = 12.5; // [10.0, 14.0] Cup depth (mm)
let bobbin_d = 20.3; // [18.0, 21.0] Bobbin diameter (mm)
let stud_d = 5.8; // [4.5, 6.2] Centre stud diameter (mm)
const floor_t = 1.0;
const horn_d = 8.0;
const horn_len = 6.0;
let ro = cup_d / 2.0;
let ri = min(bobbin_d / 2.0 + 0.35, ro - 0.8);
let h = floor_t + cup_depth;
let cup = cylinder(ro, h) - cylinder([0, 0, floor_t], "Z", ri, h);
let parts = [
    cup,
    cylinder([0, 0, floor_t - 0.5], "Z", stud_d / 2.0, cup_depth - 0.5),
    cylinder([0, 0, -horn_len], "Z", horn_d / 2.0, horn_len + 0.5),
    box_from_corners([-3.0, ro - 0.5, h - 3.0], [3.0, ro + 3.0, h]),
];
let body = fuse_all(parts);
body - fuse_all([
    cylinder([0, 0, -horn_len - 1.0], "Z", 2.0, horn_len + 1.5),
    box_from_corners([-ro - 1.0, -0.5, h - 5.0], [-ri + 0.5, 0.5, h + 1.0]),
    box_from_corners([-ro - 1.0, -ro, h - 9.0], [-ro + (ro - ri) / 2.0, -4.0, h - 2.0]),
])
