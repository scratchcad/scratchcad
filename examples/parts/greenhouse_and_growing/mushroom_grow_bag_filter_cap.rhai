// Mushroom grow bag filter cap: collar-and-cap for a spawn bag neck, 50 mm OD collar 25 mm tall with 2 mm wall, printed in one piece with a 12 mm overcap skirt (0.4 mm gap for the folded bag neck) and a 30 mm filter disc window behind a 6-spoke grille, 0.4 mm press-fit
// # Collar
let collar_od = 50.0; // [35.0, 70.0] Collar outer diameter (mm)
let collar_height = 25.0; // [15.0, 40.0] Collar height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
// # Filter
let window = 30.0; // [15.0, 45.0] Filter window diameter (mm)
let spokes = 6; // [3, 10] Number of grille spokes
let r = collar_od / 2.0;
let collar = cylinder(r, collar_height) - cylinder([0, 0, -1.0], "Z", r - wall, collar_height + 2.0);
let flange = cylinder(r + 4.0, wall) - cylinder([0, 0, -1.0], "Z", r - wall, wall + 2.0);
let cap_r = r + wall + 0.4;
let cap = cylinder([0, 0, collar_height - 12.0], "Z", cap_r, 12.0 + wall) - cylinder([0, 0, collar_height - 13.0], "Z", r + 0.4, 13.0);
let win = min(window, collar_od - 2.0 * wall - 4.0);
let opening = cylinder([0, 0, collar_height - 1.0], "Z", win / 2.0, wall + 2.0);
let grille = [];
for i in 0..spokes {
    grille.push(box_centered(win + 2.0, 2.0, wall).rotate_z(i.to_float() * 180.0 / spokes.to_float()).translate([0, 0, collar_height + wall / 2.0]));
}
let cap_open = (cap - opening) + (fuse_all(grille) & cylinder([0, 0, collar_height - 1.0], "Z", win / 2.0 + 0.5, wall + 2.0));
collar + flange + cap_open
