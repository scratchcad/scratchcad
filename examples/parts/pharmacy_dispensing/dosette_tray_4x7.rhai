// Monitored dosage tray, 7 days x 4 times: 28 compartments 22 x 22 mm and 18 mm deep with 2.5 mm corner radii and 2 mm floor fillets for easy pill pick-up, 1.6 mm dividers and 2 mm outer walls, 1.6 mm floor, 4 mm outer corner radius
let days = 7; // [1, 7] Number of days
let doses = 4; // [1, 6] Number of dose times
let cell = 22.0; // [16.0, 30.0] Compartment size (mm)
let depth = 18.0; // [12.0, 25.0] Compartment depth (mm)
const divider = 1.6;
const wall = 2.0;
const floor_t = 1.6;
let lx = days * cell + (days - 1) * divider + 2.0 * wall;
let ly = doses * cell + (doses - 1) * divider + 2.0 * wall;
let h = floor_t + depth;
let tray = box_from_corners([0, 0, 0], [lx, ly, h]);
let tray = tray.fillet(4.0, tray.edges("|Z"));
let pocket = box_from_corners([0, 0, 0], [cell, cell, depth + 1.0]);
let pocket = pocket.fillet(2.5, pocket.edges("|Z"));
let pocket = pocket.fillet(2.0, pocket.edges("<Z"));
let cutters = [];
for i in 0..days {
    for j in 0..doses {
        cutters.push(pocket.translate([wall + i * (cell + divider), wall + j * (cell + divider), floor_t]));
    }
}
tray - fuse_all(cutters)
