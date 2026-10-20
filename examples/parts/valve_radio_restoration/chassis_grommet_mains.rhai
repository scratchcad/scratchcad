// Chassis grommet for a mains cable: fits a 9.5 mm (3/8 inch) hole in 1.5 mm chassis, 13 mm flanges, 6 mm cable bore with a split for fitting
let hole = 9.5; // [9.0, 16.0] Chassis hole (mm)
let cable = 6.0; // [3.0, 7.0] Cable diameter (mm)
const panel = 1.5;
let g = cylinder([0, 0, 0], "Z", hole / 2.0 + 1.75, 1.5) + cylinder([0, 0, 1.49], "Z", hole / 2.0, panel + 0.02) + cylinder([0, 0, 1.5 + panel], "Z", hole / 2.0 + 1.75, 1.5);
g - cylinder([0, 0, -1.0], "Z", cable / 2.0, 7.0) - box_from_corners([-0.4, 0, -1.0], [0.4, hole, 7.0])
