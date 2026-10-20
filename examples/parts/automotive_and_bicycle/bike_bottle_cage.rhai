// Bottle cage for a 74 mm bottle: 2.5 mm cradle wrapping past the centre, open back window, plate with two slots 64 mm apart, bottom stop
let bottle = 74.0; // [65.0, 80.0] Bottle diameter (mm)
let height = 140.0; // [120.0, 160.0] Cage height (mm)
let r = bottle / 2.0;
let cradle = (cylinder(r + 2.5, height) - cylinder([0, 0, -1], "Z", r, height + 2.0)) & box_from_corners([-r - 5.0, -r - 5.0, 0], [r * 0.35, r + 5.0, height]);
cradle -= box_from_corners([-r - 10.0, -14.0, 25.0], [r, 14.0, height - 20.0]);
let plate = box_from_corners([-r - 5.5, -9.0, 15.0], [-r - 1.0, 9.0, height - 10.0]);
let stop = cylinder(r + 2.5, 3.0) & box_from_corners([-r - 3.0, -r - 3.0, 0], [-r * 0.3, r + 3.0, 3.0]);
let cage = fuse_all([cradle, plate, stop]);
for zc in [height / 2.0 - 32.0, height / 2.0 + 32.0] { cage -= box_from_corners([-r - 7.0, -2.6, zc - 5.0], [-r + 1.0, 2.6, zc + 5.0]); }
cage
