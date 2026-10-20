// Flat bar bottle opener: 110 x 36 mm stainless plate 3 mm thick, cap-lifting opening 30 x 18 mm with a 2 mm lifting lip, 8 mm hanging hole, rounded ends
let length = 110.0; // [80.0, 180.0] Opener length (mm)
let width = 36.0; // [28.0, 50.0] Opener width (mm)
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
let opening_length = 30.0; // [26.0, 36.0] Opening length (mm)
let opening_width = 18.0; // [14.0, 24.0] Opening width (mm)
let plate = face(rect(length - width, 0.1).offset(width / 2.0 - 0.05)).extrude([0, 0, thickness]);
plate = plate.chamfer(0.5, ">Z or <Z");
// opening near +X: a rounded slot whose inner end is squared off into the lifting lip
let cx = length / 2.0 - width / 2.0 - 4.0;
let ow = min(opening_width, width - 10.0);
let opening = face(rect(opening_length - ow, 0.1).offset(ow / 2.0 - 0.05)).extrude([0, 0, thickness + 2.0]).translate([cx - opening_length / 2.0 + ow / 2.0, 0, -1.0]);
let lip_x = cx - opening_length + ow / 2.0 + 2.0;
opening = opening & box_from_corners([lip_x, -width, -2.0], [length, width, thickness + 2.0]);
plate = plate - opening;
plate - cylinder([-length / 2.0 + 10.0, 0, -1.0], "Z", 4.0, thickness + 2.0)
