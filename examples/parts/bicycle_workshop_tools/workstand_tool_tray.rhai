// Repair stand tool tray: 300 x 150 x 30 mm open tray with 2.5 mm walls and floor, a 20 mm deep raised rack along the back with eight 12 mm screwdriver holes, and a 36 mm clamp lug with a 32.2 mm hole for the stand tube on one end
let length = 300.0; // [220.0, 400.0] Tray length (mm)
let width = 150.0; // [110.0, 200.0] Tray width (mm)
let depth = 30.0; // [20.0, 45.0] Tray depth (mm)
let tube_d = 32.0; // [25.0, 40.0] Stand tube diameter (mm)
let holes = 8; // [4, 12] Number of tool holes
const wall = 2.5;
const rack = 20.0;
let outer = box_from_corners([0, 0, 0], [length, width, depth]);
let outer = outer.fillet(6.0, outer.edges("|Z"));
let tray = outer - box_from_corners([wall, wall, wall], [length - wall, width - wall - rack, depth + 1.0]) - box_from_corners([wall, width - rack + wall, wall], [length - wall, width - wall, depth - 3.0]);
let hole_list = [];
let pitch = (length - 40.0) / (holes - 1).to_float();
for i in 0..holes {
    hole_list.push(cylinder([20.0 + i.to_float() * pitch, width - rack / 2.0, depth - 5.0], "Z", 6.0, 10.0));
}
let lug_r = tube_d / 2.0 + 4.0;
let lug = cylinder([-lug_r + 2.0, width / 2.0, 0], "Z", lug_r, depth) + box_from_corners([-lug_r + 2.0, width / 2.0 - lug_r, 0], [1.0, width / 2.0 + lug_r, depth]);
(tray + lug) - fuse_all(hole_list) - cylinder([-lug_r + 2.0, width / 2.0, -1.0], "Z", tube_d / 2.0 + 0.1, depth + 2.0)
