// Keyboard flip-out foot: 40 x 10 mm leg 3 mm thick, 8 mm tall at the free end, with a 2 mm hinge pin bore through a 4 mm barrel and a rubber pad recess 30 x 6 x 0.6 mm
let length = 40.0; // [25.0, 60.0] Foot length (mm)
let lift = 8.0; // [4.0, 14.0] Lift height (mm)
const width = 10.0;
let leg = box_from_corners([0, 0, 0], [length, width, 3.0]);
let toe = box_from_corners([length - 5.0, 0, 2.99], [length, width, lift]);
let barrel = cylinder([0, -2.0, 2.0], "Y", 2.0, width + 4.0);
let f = leg + toe + barrel;
f - cylinder([0, -3.0, 2.0], "Y", 1.0, width + 6.0) - box_from_corners([length - 4.5, 2.0, lift - 0.6], [length - 0.5, width - 2.0, lift + 1.0])
