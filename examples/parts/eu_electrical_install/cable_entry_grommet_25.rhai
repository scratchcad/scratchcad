// Membrane cable grommet for 25 mm holes: 32 mm flange 2 mm, 25 mm body 6 mm with a 2 mm groove for 1.5 mm panels, pierceable 0.6 mm membrane
let hole = 25.0; // [16.0, 40.0] Panel hole (mm)
let flange = 32.0; // [22.0, 50.0] Flange diameter (mm)
let g = cylinder(flange / 2.0, 2.0) + cylinder([0, 0, -6.0], "Z", hole / 2.0 + 1.0, 6.01);
let groove = cylinder([0, 0, -2.0], "Z", hole / 2.0 + 2.0, 2.0) - cylinder([0, 0, -3.0], "Z", hole / 2.0, 4.0);
let cone_ = cone(hole / 2.0 - 1.0, 3.0, 8.0).rotate_x(180.0).translate([0, 0, -6.0]);
let hollow = cylinder([0, 0, -5.4], "Z", hole / 2.0 - 1.0, 8.0) + cone(hole / 2.0 - 1.6, 2.4, 7.5).rotate_x(180.0).translate([0, 0, -5.39]);
g - groove + cone_ - hollow
