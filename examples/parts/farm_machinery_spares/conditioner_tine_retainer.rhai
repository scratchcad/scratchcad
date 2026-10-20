// Mower conditioner tine retainer: 60 x 32 x 9 mm clamp plate with 6 mm rounded corners, a 13 mm hole for the M12 rotor bolt (kept 1 mm narrower than the pocket), a 42 x 14 mm pocket 4 mm deep underneath that captures the flat root of a V tine, and a 3 mm anti-rotation lip 4 mm deep along one long edge that hooks the rotor tube flange
let length = 60.0; // [45.0, 80.0] Retainer length (mm)
let width = 32.0; // [24.0, 44.0] Retainer width (mm)
let thickness = 9.0; // [7.0, 14.0] Plate thickness (mm)
let root_w = 14.0; // [10.0, 20.0] Tine root width (mm)
let root_len = 42.0; // [30.0, 60.0] Tine root length (mm)
let bolt_d = 13.0; // [10.5, 17.0] Bolt hole (mm)
const pocket_d = 4.0;
const lip_t = 3.0;
const lip_h = 4.0;
let rl = min(root_len, length - 8.0);
let rw = min(root_w, width - 8.0);
let plate = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, thickness]);
let plate = plate.fillet(6.0, plate.edges("|Z"));
let lip = box_from_corners([-length / 2.0 + 6.0, width / 2.0 - lip_t, -lip_h], [length / 2.0 - 6.0, width / 2.0, 0.5]);
let body = plate + lip;
body - fuse_all([
    box_from_corners([-rl / 2.0, -rw / 2.0, -1.0], [rl / 2.0, rw / 2.0, pocket_d]),
    cylinder([0, 0, -1.0], "Z", min(bolt_d, rw - 1.0) / 2.0, thickness + 2.0),
])
