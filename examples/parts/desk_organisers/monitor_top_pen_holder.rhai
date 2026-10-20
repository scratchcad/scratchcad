// Monitor-top pen holder: saddle over an 18 mm thick monitor edge (8 mm front lip, 40 mm back leg), 36 mm wide, 3 mm walls, 2 pen tubes 13 mm bore 45 mm deep on the back of the leg
let monitor_t = 18.0; // [8.0, 40.0] Monitor top thickness (mm)
let front_lip = 8.0; // [4.0, 15.0] Front lip depth (mm)
let back_leg = 40.0; // [25.0, 70.0] Back leg depth (mm)
let width = 36.0; // [20.0, 60.0] Holder width (mm)
let tube_bore = 13.0; // [9.0, 18.0] Pen tube bore (mm)

const t = 3.0;
const tube_wall = 2.0;
let gap = monitor_t + 0.5;
// saddle in the YZ plane: front lip at y < 0, back leg at y > gap
let saddle = box_from_corners([-width / 2.0, -t, -front_lip], [width / 2.0, gap + t, t]) - box_from_corners([-width, 0, -back_leg - 1.0], [width, gap, 0]);
saddle = saddle + box_from_corners([-width / 2.0, gap, -back_leg], [width / 2.0, gap + t, 0.5]);
saddle = saddle.fillet(1.0, saddle.edges("|X"));
let ro = tube_bore / 2.0 + tube_wall;
let tubes = [];
let holes = [];
let n = max(1, (width / (2.0 * ro)).to_int());
let pitch = width / n;
for i in 0..n {
    let x = -width / 2.0 + pitch * (i + 0.5);
    let yc = gap + t + ro - 0.5;
    tubes.push(cylinder([x, yc, -45.0 - tube_wall], "Z", ro, 45.0 + tube_wall));
    holes.push(cylinder([x, yc, -45.0], "Z", tube_bore / 2.0, 50.0));
}
let holder = saddle + fuse_all(tubes);
holder - fuse_all(holes)
