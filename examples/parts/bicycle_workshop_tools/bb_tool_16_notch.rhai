// External bottom bracket cup tool for 16-notch Hollowtech II style cups: 44.6 mm cup diameter, 16 teeth 3 mm wide and 1.8 mm deep, 10 mm engagement, 4 mm floor with a 3/8 in (9.6 mm) square drive hole, two wrench flats 50 mm across
let cup_d = 44.6; // [39.0, 49.0] Cup diameter over notches (mm)
let notches = 16; // [12, 20] Number of notches
let tooth_depth = 1.8; // [1.2, 2.5] Tooth depth (mm)
let engagement = 10.0; // [6.0, 14.0] Engagement depth (mm)
const tooth_w = 3.0;
const floor_t = 4.0;
const wall = 6.0;
let ri = cup_d / 2.0 + 0.2;
let ro = ri + wall;
let h = floor_t + engagement;
let body = cylinder(ro, h) - cylinder([0, 0, floor_t], "Z", ri, h);
let flats = cup_d / 2.0 + 3.0;
body = body - box_from_corners([flats, -ro - 1.0, -1.0], [ro + 1.0, ro + 1.0, h + 1.0]) - box_from_corners([-ro - 1.0, -ro - 1.0, -1.0], [-flats, ro + 1.0, h + 1.0]);
let parts = [body];
for i in 0..notches {
    let a = i.to_float() * 360.0 / notches.to_float();
    parts.push(box_from_corners([ri - tooth_depth, -tooth_w / 2.0, floor_t - 0.5], [ri + 0.5, tooth_w / 2.0, h]).rotate_z(a));
}
let tool = fuse_all(parts);
tool - box_centered(9.6, 9.6, 3.0 * floor_t)
