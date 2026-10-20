// Wall soap dispenser drip tray: 110 x 70 mm tray 12 mm deep with a 2 mm wall and floor, 4 mm corner radii, five 2 mm drain ribs across the floor, and a 3 mm back plate 40 mm tall with two 4.5 mm screw slots 10 mm long
let length = 110.0; // [70.0, 160.0] Tray length (mm)
let depth = 70.0; // [40.0, 100.0] Tray depth (mm)
let tray_h = 12.0; // [6.0, 25.0] Tray height (mm)
let ribs = 5; // [0, 10] Number of floor ribs
const wall = 2.0;
const plate_t = 3.0;
const plate_h = 40.0;
let outer = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, tray_h]);
let outer = outer.fillet(4.0, outer.edges("|Z"));
let inner = box_from_corners([-length / 2.0 + wall, wall, wall], [length / 2.0 - wall, depth - wall, tray_h + 1.0]);
let inner = inner.fillet(2.0, inner.edges("|Z"));
let plate = box_from_corners([-length / 2.0, -plate_t, 0], [length / 2.0, 0.5, plate_h]);
let plate = plate.fillet(4.0, plate.edges("|Y and >Z"));
let parts = [(outer - inner), plate];
let sp = (length - 2.0 * wall) / (ribs + 1).to_float();
for i in 0..ribs {
    let x = -length / 2.0 + wall + sp * (i + 1).to_float();
    parts.push(box_from_corners([x - 1.0, wall - 0.5, wall - 0.5], [x + 1.0, depth - wall + 0.5, wall + 2.0]));
}
let body = fuse_all(parts);
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * length / 4.0;
    let z = plate_h - 10.0;
    cuts.push(cylinder([x, -plate_t - 1.0, z - 5.0], "Y", 2.25, plate_t + 2.0));
    cuts.push(cylinder([x, -plate_t - 1.0, z + 5.0], "Y", 2.25, plate_t + 2.0));
    cuts.push(box_from_corners([x - 2.25, -plate_t - 1.0, z - 5.0], [x + 2.25, 1.0, z + 5.0]));
}
body - fuse_all(cuts)
