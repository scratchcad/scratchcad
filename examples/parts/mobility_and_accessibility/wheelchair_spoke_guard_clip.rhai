// Wheelchair spoke guard clip: snap clip holding a 3 mm polycarbonate spoke guard disc to a 2 mm wheel spoke, 25 mm long, 10 mm wide, 3.2 mm guard slot, 2.1 mm spoke snap channel with 1.6 mm mouth
// # Clip
let length = 25.0; // [15.0, 35.0] Clip length (mm)
let width = 10.0; // [6.0, 15.0] Clip width (mm)
// # Fit
let guard_t = 3.0; // [1.5, 5.0] Guard disc thickness (mm)
let spoke = 2.0; // [1.6, 3.0] Spoke diameter (mm)
let body_t = guard_t + spoke + 6.0;
let body = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, body_t]).fillet(1.5, "|Y");
let guard_slot = box_from_corners([-1.0, -width / 2.0 - 1.0, 2.0], [length - 5.0, width / 2.0 + 1.0, 2.0 + guard_t + 0.2]);
let sz = body_t - spoke / 2.0 - 1.2;
let channel = cylinder([length / 2.0, -width / 2.0 - 1.0, sz], "Y", spoke / 2.0 + 0.05, width + 2.0);
let mouth = box_from_corners([length / 2.0 - spoke * 0.4, -width / 2.0 - 1.0, sz], [length / 2.0 + spoke * 0.4, width / 2.0 + 1.0, body_t + 1.0]);
let relief = box_from_corners([length / 2.0 - 4.0, -width / 2.0 - 1.0, sz + spoke / 2.0 + 0.5], [length / 2.0 - 3.0, width / 2.0 + 1.0, body_t + 1.0]);
body - guard_slot - channel - mouth - relief
