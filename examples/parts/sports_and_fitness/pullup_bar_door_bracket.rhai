// Doorway pull-up bar bracket: 90 x 60 x 5 mm plate with three 5 mm countersunk screw holes, open U cradle for a 32 mm bar, 6 mm wall, 28 mm deep
let bar_d = 32.0; // [25.0, 40.0] Bar diameter (mm)
let wall = 6.0; // [4.0, 10.0] Cradle wall (mm)
let depth = 28.0; // [15.0, 40.0] Cradle depth from the plate (mm)
let plate_h = 90.0; // [60.0, 140.0] Plate height (mm)
let plate_w = 60.0; // [45.0, 90.0] Plate width (mm)
const plate_t = 5.0;
const screw = 5.0;
let rb = bar_d / 2.0 + 0.5;
let ro = rb + wall;
let pw = max(plate_w, 2.0 * ro + 4.0);
let plate = box_from_corners([-pw / 2.0, -plate_h / 2.0, 0], [pw / 2.0, plate_h / 2.0, plate_t]).fillet(8.0, "|Z");
let cradle = cylinder([0, 0, plate_t - 0.5], "Z", ro, depth + 0.5) - cylinder([0, 0, plate_t + 3.0], "Z", rb, depth + 1.0);
cradle = cradle - box_from_corners([-rb, 0, plate_t + 3.0], [rb, ro + 1.0, plate_t + depth + 1.0]);
let bracket = plate + cradle;
for y in [-plate_h / 2.0 + 10.0, plate_h / 2.0 - 10.0] {
    bracket = bracket - cylinder([0, y, -1.0], "Z", screw / 2.0, plate_t + 2.0) - cone(screw / 2.0, screw / 2.0 + 2.5, 2.5).translate([0, y, plate_t - 2.49]);
}
let sx = pw / 2.0 - 8.0;
bracket - cylinder([sx, 0, -1.0], "Z", screw / 2.0, plate_t + 2.0) - cone(screw / 2.0, screw / 2.0 + 2.5, 2.5).translate([sx, 0, plate_t - 2.49])
