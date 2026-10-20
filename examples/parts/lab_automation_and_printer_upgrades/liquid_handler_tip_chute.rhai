// Liquid handler tip waste chute: SBS footprint mounting plate 127.76 x 85.48 x 3 mm, 100 x 30 mm mouth in the plate dropping into a 100 mm wide U-channel chute 25 mm deep with 2 mm walls, sloping down at 30 degrees for 150 mm off the deck edge
let mouth_l = 100.0; // [60.0, 115.0] Mouth length (mm)
let mouth_w = 30.0; // [20.0, 60.0] Mouth width (mm)
let chute_l = 150.0; // [80.0, 250.0] Chute length (mm)
let slope = 30.0; // [15.0, 60.0] Chute slope (degrees)
const sbs_l = 127.76;
const sbs_w = 85.48;
const wall = 2.0;
const plate_t = 3.0;
const ch = 25.0;
let plate = box_centered(sbs_l, sbs_w, plate_t).translate([0, 0, -plate_t / 2.0]);
plate = plate.fillet(3.0, "|Z");
// a U-channel running out along +Y and down, hinged at the far edge of the mouth
let tube_o = box_from_corners([-mouth_l / 2.0 - wall, -mouth_w / 2.0 - wall, -ch - wall], [mouth_l / 2.0 + wall, chute_l, 0]);
let tube_i = box_from_corners([-mouth_l / 2.0, -mouth_w / 2.0, -ch], [mouth_l / 2.0, chute_l + 1.0, 1.0]);
let chute = (tube_o - tube_i).rotate([0, mouth_w / 2.0, 0], "X", -slope);
// keep it below the plate's top face
chute = chute & box_centered(sbs_l * 4.0, chute_l * 4.0, chute_l * 4.0).translate([0, 0, -chute_l * 2.0]);
let mouth = box_centered(mouth_l, mouth_w, plate_t + 2.0).translate([0, 0, -plate_t / 2.0]);
plate + chute - mouth - tube_i.rotate([0, mouth_w / 2.0, 0], "X", -slope)
