// Arduino Mega 2560 case base: board 101.6 x 53.3 mm with 6 holes (13.97,2.54) (15.24,50.8) (66.04,7.62) (66.04,35.56) (90.17,50.8) (96.52,2.54), 2 mm walls, 2 mm floor, 5 mm standoffs, USB-B 12.5 x 11.5 and DC jack 9.5 x 11.5 cutouts
let wall = 2.0; // [1.2, 3.5] Wall thickness (mm)
let floor_t = 2.0; // [1.2, 3.5] Floor thickness (mm)
let standoff = 5.0; // [3.0, 10.0] Standoff height (mm)
let height = 22.0; // [16.0, 40.0] Wall height (mm)
let clearance = 1.0; // [0.4, 2.5] Board clearance (mm)
let corner = 3.0; // [1.0, 6.0] Corner radius (mm)
const board_w = 101.6;
const board_h = 53.3;
let ox = wall + clearance;
let oy = wall + clearance;
let w = board_w + 2.0 * ox;
let d = board_h + 2.0 * oy;
let h = max(height, floor_t + standoff + 14.0);
let outer = box(w, d, h);
let outer = outer.fillet(min(corner, wall + clearance - 0.1), outer.edges("|Z"));
let shell = outer - box_from_corners([wall, wall, floor_t], [w - wall, d - wall, h + 1.0]);
let holes = [[13.97, 2.54], [15.24, 50.8], [66.04, 7.62], [66.04, 35.56], [90.17, 50.8], [96.52, 2.54]];
let posts = [shell];
let drills = [];
for p in holes {
    posts.push(cylinder([ox + p[0], oy + p[1], floor_t - 0.5], "Z", 2.75, standoff + 0.5));
    drills.push(cylinder([ox + p[0], oy + p[1], 1.0], "Z", 1.25, standoff + floor_t));
}
let pcb_top = floor_t + standoff + 1.6;
drills.push(box_from_corners([-1, oy + 38.1 - 6.25, pcb_top - 0.5], [wall + 1.0, oy + 38.1 + 6.25, pcb_top + 11.0]));
drills.push(box_from_corners([-1, oy + 7.6 - 4.75, pcb_top - 0.5], [wall + 1.0, oy + 7.6 + 4.75, pcb_top + 11.0]));
fuse_all(posts) - compound(drills)
