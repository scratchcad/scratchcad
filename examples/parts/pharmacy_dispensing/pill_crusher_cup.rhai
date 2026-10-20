// Pill crusher cup: 45 mm cup 28 mm tall with a 2.5 mm wall and 4 mm floor, 8 radial grinding ribs 1.5 mm high and 1.6 mm wide on the floor inside, and 18 vertical grip ribs 2 mm wide standing 1.2 mm proud outside, stopping 3 mm from each end
let cup_d = 45.0; // [35.0, 60.0] Cup outside diameter (mm)
let cup_h = 28.0; // [20.0, 40.0] Cup height (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
let ribs = 8; // [4, 12] Number of grinding ribs
let grips = 18; // [10, 30] Number of grip ribs
const floor_t = 4.0;
const rib_h = 1.5;
let ro = cup_d / 2.0;
let ri = ro - wall;
let cup = cylinder(ro, cup_h) - cylinder([0, 0, floor_t], "Z", ri, cup_h);
let parts = [cup];
for i in 0..ribs {
    parts.push(box_from_corners([4.0, -0.8, floor_t - 0.5], [ri + 0.5, 0.8, floor_t + rib_h]).rotate_z(i * 360.0 / ribs));
}
for i in 0..grips {
    parts.push(box_from_corners([ro - 0.5, -1.0, 3.0], [ro + 1.2, 1.0, cup_h - 3.0]).rotate_z((i + 0.5) * 360.0 / grips));
}
fuse_all(parts)
