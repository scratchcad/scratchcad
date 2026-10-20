// Cold-shoe bubble level holder: 18.6 x 18 mm shoe foot 2 mm, 12 mm bubble vial pocket in a 22 x 22 x 10 mm block
let foot_w = 18.6; // [18.0, 19.0] Shoe foot width (mm)
let vial = 12.0; // [8.0, 15.0] Vial diameter (mm)
let foot = box_centered(foot_w, 18.0, 2.0).translate([0, 0, 1.0]);
let neck = box_centered(12.0, 18.0, 2.0).translate([0, 0, 2.99]);
let block = box_centered(22.0, 22.0, 10.0).translate([0, 0, 8.98]);
let b = block.fillet(2.0, block.edges("|Z"));
foot + neck + b - cylinder([0, 0, 9.0], "Z", vial / 2.0, 6.0)
