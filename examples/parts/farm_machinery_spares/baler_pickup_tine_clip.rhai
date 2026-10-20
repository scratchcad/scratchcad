// Baler pickup tine clamp clip: 50 x 25 x 6 mm clamp plate with an 8.5 mm hole for the M8 bolt through the tine bar, two 5.7 mm half-round grooves underneath 30 mm apart to seat the coils of a 5.5 mm double tine, and 2 mm chamfered top edges
let length = 50.0; // [40.0, 70.0] Clip length (mm)
let width = 25.0; // [18.0, 35.0] Clip width (mm)
let thickness = 6.0; // [5.0, 10.0] Clip thickness (mm)
let wire_d = 5.7; // [4.5, 7.0] Tine wire groove (mm)
let groove_pitch = 30.0; // [24.0, 40.0] Groove spacing (mm)
let bolt_d = 8.5; // [6.5, 10.5] Bolt hole (mm)
let gp = min(groove_pitch, length - wire_d - 6.0);
let plate = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, thickness]);
let plate = plate.chamfer(2.0, plate.edges(">Z"));
plate - fuse_all([
    cylinder([-gp / 2.0, -width / 2.0 - 1.0, 0], "Y", wire_d / 2.0, width + 2.0),
    cylinder([gp / 2.0, -width / 2.0 - 1.0, 0], "Y", wire_d / 2.0, width + 2.0),
    cylinder([0, 0, -1.0], "Z", bolt_d / 2.0, thickness + 2.0),
])
