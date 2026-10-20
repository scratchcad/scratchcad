// Desk cable grommet, 60 mm: 66 mm flange 3 mm, 59.5 mm sleeve 20 mm, cap with 30 x 12 mm cable slot
let hole = 60.0; // [35.0, 80.0] Desk hole (mm)
let sleeve_l = 20.0; // [15.0, 40.0] Sleeve depth (mm)
let flange = 66.0; // [40.0, 90.0] Flange diameter (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let g = cylinder(flange / 2.0, 3.0) + cylinder([0, 0, -sleeve_l], "Z", hole / 2.0 - 0.25, sleeve_l + 0.01);
g - cylinder([0, 0, -sleeve_l - 1.0], "Z", hole / 2.0 - 0.25 - wall, sleeve_l + 2.0) - cylinder([0, 0, 1.0], "Z", hole / 2.0 + 0.5, 3.0)
