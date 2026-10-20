// End cap for an aluminium order ticket rail: 3 mm plate matching the 25 x 32 mm profile with 4 mm corner radii, a hollow 12 mm spigot (1.6 mm walls) that pushes into the extrusion and a 4.5 mm countersunk wall screw hole
let depth = 25.0; // [18.0, 40.0] Rail depth (mm)
let height = 32.0; // [22.0, 50.0] Rail height (mm)
let spigot = 12.0; // [6.0, 20.0] Spigot length (mm)
const t = 3.0;
const wall = 1.6;
let plate = box_from_corners([0, -depth / 2.0, -height / 2.0], [t, depth / 2.0, height / 2.0]);
plate = plate.fillet(4.0, plate.edges("|X"));
let sp = box_from_corners([t - 0.01, -depth / 2.0 + 1.5, -height / 2.0 + 1.5], [t + spigot, depth / 2.0 - 1.5, height / 2.0 - 1.5]);
sp = sp - box_from_corners([t + 1.0, -depth / 2.0 + 1.5 + wall, -height / 2.0 + 1.5 + wall], [t + spigot + 1.0, depth / 2.0 - 1.5 - wall, height / 2.0 - 1.5 - wall]);
let cap = plate + sp;
cap - cylinder([-1.0, 0, 0], "X", 2.25, t + 3.0) - cone(4.5, 2.25, 2.25).rotate_y(90.0).translate([-0.01, 0, 0])
