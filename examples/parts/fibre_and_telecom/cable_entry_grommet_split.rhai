// Split cable entry grommet: 32 mm grommet for a 25 mm hole in 2 mm sheet, 9 mm cable bore, 3 mm flanges both sides and a 1 mm split for fitting over an installed cable
let hole = 25.0; // [16.0, 40.0] Panel hole (mm)
let cable = 9.0; // [4.0, 15.0] Cable diameter (mm)
const panel = 2.0;
let g = cylinder([0, 0, 0], "Z", hole / 2.0 + 3.5, 3.0) + cylinder([0, 0, 2.99], "Z", hole / 2.0 - 0.2, panel + 0.02) + cylinder([0, 0, 3.0 + panel], "Z", hole / 2.0 + 3.5, 3.0);
g - cylinder([0, 0, -1.0], "Z", cable / 2.0, 12.0) - box_from_corners([-0.5, 0, -1.0], [0.5, hole, 12.0])
