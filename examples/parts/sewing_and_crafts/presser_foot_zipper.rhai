// Snap-on zipper presser foot: 25 x 12 mm sole, 3 mm needle notches each side, 5 mm snap bar
let length = 25.0; // [20.0, 35.0] Sole length (mm)
let width = 12.0; // [8.0, 18.0] Sole width (mm)
let sole = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, 2.0]);
let toe = sole.fillet(1.5, sole.edges("|Z and >X"));
let neck = box_from_corners([-4.0, -2.0, 1.9], [4.0, 2.0, 10.0]);
let bar = cylinder([-5.0, 0, 9.0], "X", 1.25, 10.0);
let notches = box_from_corners([-2.0, width / 2.0 - 3.0, -1], [2.0, width / 2.0 + 1.0, 3.0]) + box_from_corners([-2.0, -width / 2.0 - 1.0, -1], [2.0, -width / 2.0 + 3.0, 3.0]);
toe + neck + bar - notches
