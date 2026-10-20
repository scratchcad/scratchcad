// Hi-vis badge reel housing: 32 mm round case 10 mm deep, 1.5 mm wall, 3 mm cord exit tube, belt clip tab 15 x 25 mm on the back
let diameter = 32.0; // [28.0, 40.0] Case diameter (mm)
let depth = 10.0; // [8.0, 14.0] Case depth (mm)
let wall = 1.5; // [1.2, 2.5] Wall thickness (mm)
let cord_exit = 3.0; // [2.0, 4.0] Cord exit hole (mm)
let r = diameter / 2.0;
let shell = cylinder(r, depth) - cylinder([0, 0, wall], "Z", r - wall, depth);
let exit_boss = cylinder([0, -r + 1.0, depth / 2.0], "-Y", 3.0, 4.0);
let exit_hole = cylinder([0, 0, depth / 2.0], "-Y", cord_exit / 2.0, r + 6.0);
let axle = cylinder([0, 0, wall - 0.01], "Z", 3.0, depth - wall) - cylinder([0, 0, wall], "Z", 1.5, depth);
let clip_root = box_from_corners([-7.5, -r + 4.0, -2.0], [7.5, -r + 8.0, 0.01]);
let clip = box_from_corners([-7.5, -r + 4.0, -3.5], [7.5, r - 4.0, -2.0]);
shell + exit_boss + axle + clip_root + clip - exit_hole
