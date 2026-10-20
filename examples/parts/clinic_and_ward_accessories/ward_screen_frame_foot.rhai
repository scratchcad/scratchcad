// Ward privacy screen frame foot: 300 x 40 mm foot bar 25 mm tall with 15 mm chamfered ends, a 25.4 mm socket 30 mm deep for the frame tube, a 4 mm M5 cross-bolt hole and 3 mm glide pads under each end
let length = 300.0; // [200.0, 400.0] Foot length (mm)
let tube_d = 25.4; // [19.0, 32.0] Frame tube diameter (mm)
let height = 25.0; // [20.0, 35.0] Foot height (mm)
const width = 40.0;
let f = face(polygon([[-length / 2.0, 0, 3.0], [length / 2.0, 0, 3.0], [length / 2.0, 0, 8.0], [length / 2.0 - 15.0, 0, height], [-length / 2.0 + 15.0, 0, height], [-length / 2.0, 0, 8.0]])).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let boss = cylinder([0, 0, 3.0], "Z", tube_d / 2.0 + 6.0, height + 15.0);
let pads = box_from_corners([-length / 2.0 + 5.0, -width / 2.0 + 5.0, 0], [-length / 2.0 + 45.0, width / 2.0 - 5.0, 3.01]) + box_from_corners([length / 2.0 - 45.0, -width / 2.0 + 5.0, 0], [length / 2.0 - 5.0, width / 2.0 - 5.0, 3.01]);
f + boss + pads - cylinder([0, 0, height + 18.0 - 30.0], "Z", tube_d / 2.0 + 0.2, 31.0) - cylinder([0, -width, height + 8.0], "Y", 2.5, 2.0 * width)
