// Fluke (Danforth-style) anchor, 4 kg class: 400 mm shank, two 3 mm triangular flukes 330 mm across, crown and 16 mm stock bar
let len = 400.0; // [250.0, 600.0] Shank length (mm)
let s = len / 400.0;
let shank = box_from_corners([-6.0, -15.0 * s, 0], [6.0, 15.0 * s, len]).fillet(4.0, "|Z") - cylinder([-7.0, 0, len - 15.0 * s], "X", 6.0, 14.0);
let fluke = polygon([[0, 0], [165.0 * s, 0], [150.0 * s, 230.0 * s], [20.0 * s, 260.0 * s]]).to_face().extrude(3.0);
let crown = box_from_corners([-170.0 * s, -20.0 * s, -10.0], [170.0 * s, 20.0 * s, 10.0]);
let flukes = fuse_all([fluke.rotate_x(-90.0).rotate_y(-30.0).translate([8.0, 0, 0]), fluke.mirror([1, 0, 0]).rotate_x(-90.0).rotate_y(30.0).translate([-8.0, 0, 0])]);
let stock = cylinder([-180.0 * s, 0, 0], "X", 8.0, 360.0 * s);
compound([fuse_all([shank, crown, stock]), flukes])
