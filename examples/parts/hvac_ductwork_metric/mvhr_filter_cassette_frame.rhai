// MVHR filter cassette frame 180 x 120 x 20 mm: 2 mm side walls, 3 mm media lip, 3 x 2 support grid of 1.5 mm ribs on the downstream face, 25 x 12 mm finger pull tab with an 8 mm hole
let length = 180.0; // [100.0, 300.0] Frame length (mm)
let width = 120.0; // [80.0, 200.0] Frame width (mm)
let depth = 20.0; // [10.0, 40.0] Frame depth (mm)
let cols = 3; // [1, 6] Number of grid bays along the length
let rows = 2; // [1, 4] Number of grid bays across
const wall = 2.0;
const lip = 3.0;
const rib = 1.5;
let frame = box_centered(length, width, depth).translate([0, 0, depth / 2.0]) - box_centered(length - 2.0 * wall, width - 2.0 * wall, depth + 2.0).translate([0, 0, depth / 2.0]);
let lip_ring = box_centered(length - 1.0, width - 1.0, 1.5).translate([0, 0, 0.75]) - box_centered(length - 2.0 * (wall + lip), width - 2.0 * (wall + lip), 4.0);
let ribs = [];
for i in 1..cols {
    let x = -length / 2.0 + i.to_float() * length / cols.to_float();
    ribs.push(box_centered(rib, width - 1.0, 4.0).translate([x, 0, 2.0]));
}
for j in 1..rows {
    let y = -width / 2.0 + j.to_float() * width / rows.to_float();
    ribs.push(box_centered(length - 1.0, rib, 4.0).translate([0, y, 2.0]));
}
let tab = box_from_corners([-12.5, width / 2.0 - 1.0, 0], [12.5, width / 2.0 + 12.0, 2.0]);
tab = tab.fillet(4.0, tab.edges("|Z and >Y"));
tab = tab - cylinder([0, width / 2.0 + 6.0, -1], "Z", 4.0, 4.0);
fuse_all([frame, lip_ring, tab] + ribs)
