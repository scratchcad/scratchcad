// Shower handset wall bracket: 40 mm wall puck 14 mm, 16 mm arm, conical cradle for a 25-28 mm handle tilted 15 degrees, 14 mm front slot for the hose
let puck_d = 40.0; // [32.0, 55.0] Wall puck diameter (mm)
let reach = 40.0; // [30.0, 60.0] Cradle centre from the wall (mm)
let handle_d = 26.0; // [22.0, 32.0] Handle diameter at the cradle (mm)
let tilt = 15.0; // [0.0, 30.0] Cradle tilt (degrees)
let slot = 14.0; // [10.0, 18.0] Hose slot width (mm)
const h = 30.0;
let ri = handle_d / 2.0;
let c = [0, reach, 0];
let outer = cone(ri + 2.5, ri + 4.5, h).translate([0, reach, -h / 2.0]).rotate(c, "X", tilt);
let inner = cone(ri - 0.8, ri + 1.2, h + 6.0).translate([0, reach, -h / 2.0 - 3.0]).rotate(c, "X", tilt);
let gap = box_from_corners([-slot / 2.0, reach, -h], [slot / 2.0, reach + ri + 10.0, h]).rotate(c, "X", tilt);
let puck = cylinder([0, 0, 0], "Y", puck_d / 2.0, 14.0);
let p = puck.fillet(2.0, puck.edges(">Y"));
let arm = box_from_corners([-8.0, 10.0, -7.0], [8.0, reach - ri + 2.0, 7.0]);
let screw = cylinder([0, -1, 0], "Y", 2.2, 16.0) + cylinder([0, 9.0, 0], "Y", 4.5, 4.0);
p + arm + outer - inner - gap - screw
