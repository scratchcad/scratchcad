// Four-sided spoke wrench for 3.3 mm (DT 14G) nipples: 26 mm round grip 5 mm thick, 2.4 mm spoke slot to the centre, 3.3 mm square nipple pocket 3.5 mm deep, two thumb flats 20 mm apart and a 4 mm key-ring hole
let nipple = 3.3; // [3.0, 4.0] Nipple across flats (mm)
let grip_d = 26.0; // [20.0, 34.0] Grip diameter (mm)
let thickness = 5.0; // [4.0, 7.0] Thickness (mm)
const spoke_slot = 2.4;
let pocket_depth = thickness - 1.5;
let body = cylinder(grip_d / 2.0, thickness);
let body = body.fillet(0.8, body.edges(">Z or <Z"));
let flat = grip_d / 2.0 - 3.0;
let cuts = [
    box_from_corners([flat, -grip_d, -1.0], [grip_d, grip_d, thickness + 1.0]),
    box_from_corners([-grip_d, -grip_d, -1.0], [-flat, grip_d, thickness + 1.0]),
    box_from_corners([-spoke_slot / 2.0, 0, -1.0], [spoke_slot / 2.0, grip_d, thickness + 1.0]),
    box_centered(nipple, nipple, 2.0 * pocket_depth).translate([0, 0, thickness]),
    cylinder([0, -grip_d / 2.0 + 5.0, -1.0], "Z", 2.0, thickness + 2.0),
];
body - fuse_all(cuts)
