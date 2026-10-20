// Glue-in cord end cap for 3 mm leather cord: 5 mm diameter, 8 mm long, 3.1 mm bore 7 mm deep, domed top with a 1.2 mm thick loop and 1.6 mm jump-ring hole
let cord_diameter = 3.0; // [1.0, 6.0] Cord diameter (mm)
let wall = 1.0; // [0.5, 1.5] Wall thickness (mm)
let cap_length = 8.0; // [4.0, 14.0] Cap length (mm)
let loop_hole = 1.6; // [1.0, 3.0] Loop hole diameter (mm)
let rb = cord_diameter / 2.0 + 0.05;
let ro = rb + wall;
let depth = cap_length - 1.0;
let profile = sketch("XZ")
    .move_to(rb, 0)
    .hline_to(ro)
    .vline_to(cap_length - ro * 0.4)
    .arc_to(ro * 0.7, cap_length - ro * 0.1, 0, cap_length)
    .vline_to(depth)
    .hline_to(rb)
    .close();
let cap = profile.to_face().revolve("Z", 360);
let rl = loop_hole / 2.0 + 0.9;
let lp = cylinder([0, -0.6, cap_length + rl - 0.6], "Y", rl, 1.2) + box_from_corners([-rl, -0.6, cap_length - 0.8], [rl, 0.6, cap_length + rl - 0.6]);
lp = lp - cylinder([0, -2, cap_length + rl - 0.6], "Y", loop_hole / 2.0, 4);
cap + lp
