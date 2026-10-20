// Chain wear checker for 1/2 in pitch chain, 0.75 % limit: 3 mm steel plate 16 mm wide, 3.5 mm hook peg and 4 mm wedge tooth 6 mm tall spaced 6 pitches x 12.7 mm x 1.0075 = 76.77 mm, 6 mm hang hole, rounded ends
let pitches = 6; // [4, 10] Pitches checked
let wear = 0.75; // [0.5, 1.0] Wear limit (%)
let plate_w = 16.0; // [12.0, 22.0] Plate width (mm)
let plate_t = 3.0; // [2.0, 5.0] Plate thickness (mm)
const peg_d = 3.5;
const peg_h = 6.0;
let spacing = pitches.to_float() * 12.7 * (1.0 + wear / 100.0);
let length = spacing + 30.0;
let plate = box_from_corners([-12.0, -plate_w / 2.0, 0], [length - 12.0, plate_w / 2.0, plate_t]);
let plate = plate.fillet(plate_w / 2.0 - 0.5, plate.edges("|Z"));
let peg = cylinder([0, 0, plate_t - 0.5], "Z", peg_d / 2.0, peg_h + 0.5);
let tooth = polygon([[spacing - 2.0, 0, plate_t - 0.5], [spacing + 2.0, 0, plate_t - 0.5], [spacing + 0.6, 0, plate_t + peg_h], [spacing - 0.6, 0, plate_t + peg_h]]).to_face().extrude([0, peg_d, 0]).translate([0, -peg_d / 2.0, 0]);
fuse_all([plate, peg, tooth]) - cylinder([length - 20.0, 0, -1.0], "Z", 3.0, plate_t + 2.0)
