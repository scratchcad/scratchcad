// Hard hat chin strap clip: 22 x 14 mm hook clip 2.5 mm thick that snaps onto the 6 mm suspension lug, 13 mm strap slot 3 mm wide
let width = 22.0; // [16.0, 30.0] Clip width (mm)
let strap = 13.0; // [10.0, 20.0] Strap width (mm)
let thickness = 2.5; // [1.8, 3.5] Thickness (mm)
let lug = 6.0; // [4.0, 8.0] Lug diameter (mm)
let length = 14.0 + lug;
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, length, thickness]);
let p = plate.fillet(3.0, plate.edges("|Z"));
let strap_slot = box_from_corners([-strap / 2.0, 3.0, -1], [strap / 2.0, 6.0, thickness + 1.0]);
// open-mouthed hook for the lug, 0.4 mm narrower than the lug for the snap
let hook = cylinder([0, length - lug / 2.0 - 2.0, -1], "Z", lug / 2.0, thickness + 2.0) + box_from_corners([-(lug - 0.8) / 2.0, length - lug / 2.0 - 2.0, -1], [(lug - 0.8) / 2.0, length + 1.0, thickness + 1.0]);
p - strap_slot - hook
