// Downtube battery rail lock latch: 30 x 15 x 12 mm body, 8 mm spring bolt bore, 45 degree lead-in, 1 M5 mounting hole, spring bolt shown separately (two solids)
let length = 30.0; // [20.0, 45.0] Body length (mm)
let width = 15.0; // [10.0, 20.0] Body width (mm)
let height = 12.0; // [8.0, 18.0] Body height (mm)
let bolt = 8.0; // [5.0, 12.0] Bolt diameter (mm)
let body = box_from_corners([0, 0, 0], [length, width, height]);
let b = body.fillet(2.0, body.edges("|Z"));
let bore = cylinder([-1, width / 2.0, height / 2.0], "X", bolt / 2.0, length - 5.0);
let bolt_ = cylinder([-8.0, width / 2.0, height / 2.0], "X", bolt / 2.0 - 0.3, 20.0) - polygon([[-8.01, -1.0, height / 2.0 - 0.5], [-8.01 + bolt / 2.0 + 0.5, -1.0, height / 2.0 + bolt / 2.0], [-8.01, -1.0, height / 2.0 + bolt / 2.0]]).to_face().extrude([0, width + 2.0, 0]);
let pin = box_from_corners([10.0, width / 2.0 - 1.0, height / 2.0], [14.0, width / 2.0 + 1.0, height + 6.0]);
let slot = box_from_corners([8.0, width / 2.0 - 1.5, height / 2.0], [24.0, width / 2.0 + 1.5, height + 1.0]);
compound([b - bore - slot - cylinder([length / 2.0 - 10.0 + 15.0, width / 2.0, -1], "Z", 2.6, height + 2.0), bolt_ + pin])
