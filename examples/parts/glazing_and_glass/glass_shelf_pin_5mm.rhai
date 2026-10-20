// Glass shelf support pin: 5 mm peg 8 mm long into the cabinet side, 12 mm square support pad 3 mm thick with a 1.5 mm rubber-cup lip on top to hold 6 mm glass
let peg = 5.0; // [3.0, 8.0] Peg diameter (mm)
let pad = 12.0; // [8.0, 18.0] Pad size (mm)
let p = cylinder([-8.0, 0, 0], "X", peg / 2.0, 8.01);
let support = box_from_corners([0, -pad / 2.0, -peg / 2.0], [pad, pad / 2.0, -peg / 2.0 + 3.0]);
let lip = box_from_corners([pad - 1.5, -pad / 2.0, -peg / 2.0 + 2.99], [pad, pad / 2.0, -peg / 2.0 + 4.5]);
let back = box_from_corners([0, -pad / 2.0, -peg / 2.0], [2.0, pad / 2.0, peg / 2.0 + 1.0]);
p + support + lip + back
