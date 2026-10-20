// Medicine cup stand for 30 ml graduated cups (44 mm rim, 30 mm base, 38 mm tall): 4 cups in a row at 52 mm pitch, 45 mm high and 56 mm deep, a 5 mm top plate with 40 mm holes chamfered 1 mm, a 3 mm base plate and two 4 mm end walls
let cups = 4; // [2, 8] Number of cups
let hole_d = 40.0; // [34.0, 44.0] Hole diameter (mm)
let pitch = 52.0; // [46.0, 64.0] Cup spacing (mm)
let height = 45.0; // [36.0, 60.0] Stand height (mm)
let depth = 56.0; // [48.0, 70.0] Stand depth (mm)
const top_t = 5.0;
const base_t = 3.0;
const wall_t = 4.0;
let len = cups * pitch + 2.0 * wall_t;
let frame = fuse_all([
    box_from_corners([0, 0, height - top_t], [len, depth, height]),
    box_from_corners([0, 0, 0], [len, depth, base_t]),
    box_from_corners([0, 0, 0], [wall_t, depth, height]),
    box_from_corners([len - wall_t, 0, 0], [len, depth, height]),
]);
let holes = [];
for i in 0..cups {
    holes.push(cylinder([wall_t + pitch / 2.0 + i * pitch, depth / 2.0, height - top_t - 1.0], "Z", hole_d / 2.0, top_t + 2.0));
}
let stand = frame - fuse_all(holes);
stand.chamfer(1.0, stand.edges("%CIRCLE and >Z"))
