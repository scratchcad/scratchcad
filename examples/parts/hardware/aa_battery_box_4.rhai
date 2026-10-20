// 4 x AA battery holder: cells 14.5 mm x 50.5 mm side by side, 1.5 mm walls, contact slots at each end
let cells = 4; // [1, 8] Cells
let cell_d = 14.5; // [10.0, 34.0] Cell diameter (mm)
let cell_l = 50.5; // [44.0, 70.0] Cell length (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let gap = 0.6;
let pitch = cell_d + gap;
let w = cells.to_float() * pitch + 2.0 * wall;
let l = cell_l + 2.0 * wall + 2.0;
let h = cell_d * 0.75 + wall;
let box_ = box(w, l, h).fillet(1.0, "|Z");
let pockets = [];
for i in 0..cells {
    let x = wall + pitch / 2.0 + i.to_float() * pitch;
    pockets.push(cylinder([x, wall, wall + cell_d / 2.0], "Y", cell_d / 2.0 + 0.2, l - 2.0 * wall));
    pockets.push(box_from_corners([x - 3.0, -1, wall + 2.0], [x + 3.0, l + 1, h + 1]));
}
box_ - fuse_all(pockets)
