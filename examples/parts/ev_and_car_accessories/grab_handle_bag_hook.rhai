// Car roof grab handle bag hook: S-hook 15 mm wide 4.5 mm thick, 28 mm top loop for the grab handle, 20 mm bottom loop for bag handles, 75 mm between loop centres
let handle_gap = 28.0; // [20.0, 40.0] Top loop inside diameter (mm)
let bag_gap = 20.0; // [14.0, 30.0] Bottom loop inside diameter (mm)
let spacing = 75.0; // [55.0, 110.0] Loop centre distance (mm)
let width = 15.0; // [10.0, 22.0] Hook width (mm)
let wall = 4.5; // [3.5, 6.0] Wall (mm)

let rt = handle_gap / 2.0;
let rb = bag_gap / 2.0;
let ring = |cx, cz, ri| {
    cylinder([cx, -width / 2.0, cz], "Y", ri + wall, width) - cylinder([cx, -width / 2.0 - 1.0, cz], "Y", ri, width + 2.0)
};
// top loop open below on the right, bottom loop open above on the right
let top = ring.call(0.0, spacing, rt) - box_from_corners([0, -width, spacing - rt - wall - 1.0], [rt + wall + 1.0, width, spacing]);
let bx = -rt + rb;
let bottom = ring.call(bx, 0.0, rb) - box_from_corners([bx, -width, 0], [bx + rb + wall + 1.0, width, rb + wall + 1.0]);
let stem = box_from_corners([-rt - wall, -width / 2.0, 0], [-rt, width / 2.0, spacing]);
let hook = fuse_all([top, bottom, stem]);
// rounded tips
let tips = [cylinder([rt + wall / 2.0, -width / 2.0, spacing], "Y", wall / 2.0, width), cylinder([bx + rb + wall / 2.0, -width / 2.0, 0], "Y", wall / 2.0, width)];
hook + compound(tips)
