// Outboard water pump impeller housing liner: 58 mm cup 25 mm tall with a 50 mm impeller chamber, a 6 mm deep cam flat on one side that flexes the vanes, a 2 mm floor with a 16 mm drive shaft hole, a 4 x 12 mm outlet port through the wall next to the cam and a 3 mm locating key 2 mm proud on the outside
let chamber_d = 50.0; // [30.0, 70.0] Impeller chamber diameter (mm)
let height = 25.0; // [15.0, 40.0] Liner height (mm)
let cam_depth = 6.0; // [3.0, 9.0] Cam depth (mm)
const wall = 4.0;
const floor_t = 2.0;
let ri = chamber_d / 2.0;
let ro = ri + wall;
let cup = cylinder([0, 0, 0], "Z", ro, height) + box_centered(3.0, 4.0, height).translate([0, ro + 1.0, height / 2.0]);
let chamber = cylinder([0, 0, floor_t], "Z", ri, height) - box_from_corners([ri - cam_depth, -ri, floor_t - 1.0], [ri + 1.0, ri * 0.25, height + 2.0]);
let port = box_centered(wall + 4.0, 12.0, 4.0).translate([ri + wall / 2.0 - 1.0, ri * 0.25 + 8.0, height - 6.0]);
let shaft = cylinder([0, 0, -1.0], "Z", 8.0, floor_t + 2.0);
cup - chamber - port - shaft
