// Drawer divider clip: saddle over a 15 mm drawer side 22 mm deep, 2.5 mm walls, 20 mm wide, holding a 6 mm divider board in a 6.3 mm slot 30 mm tall on the inside face, grip bumps on the saddle
let side_t = 15.0; // [10.0, 22.0] Drawer side thickness (mm)
let grip = 22.0; // [12.0, 35.0] Saddle depth (mm)
let board = 6.3; // [3.0, 12.5] Divider slot (mm)
let slot_h = 30.0; // [15.0, 60.0] Slot height (mm)
let width = 20.0; // [14.0, 30.0] Clip width (mm)

const wall = 2.5;
// saddle: an inverted U over the drawer side, in the YZ plane, extruded along X
let saddle = box_from_corners([-width / 2.0, -wall, -grip], [width / 2.0, side_t + wall, wall]) - box_from_corners([-width, 0, -grip - 1.0], [width, side_t, 0]);
saddle = saddle.fillet(1.2, saddle.edges("|X and >Z"));
let bumps = [];
for z in [-grip * 0.4, -grip * 0.8] {
    bumps.push(cylinder([-width / 2.0, -0.6, z], "X", 1.0, width));
}
// slot block hanging on the drawer-inside face (y < 0)
let bw = board + 2.0 * wall;
let block = box_from_corners([-bw / 2.0, -wall - 10.0, -slot_h], [bw / 2.0, -wall + 0.5, wall - 1.5]);
block = block - box_from_corners([-board / 2.0, -wall - 11.0, -slot_h - 1.0], [board / 2.0, -wall - 1.5, wall + 1.0]);
fuse_all([saddle, fuse_all(bumps), block])
