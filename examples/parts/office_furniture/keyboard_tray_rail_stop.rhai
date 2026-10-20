// Keyboard tray slide rail end stop: 20 x 15 x 10 mm block that snaps into a 12 mm C-rail with an 8 mm bumper face
let rail = 12.0; // [8.0, 20.0] Rail inside width (mm)
let length = 20.0; // [12.0, 30.0] Stop length (mm)
let body = box_centered(length, rail - 0.4, 6.0).translate([0, 0, 3.0]);
let ears = box_centered(6.0, rail + 3.0, 1.5).translate([0, 0, 0.75]);
let bumper = cylinder([length / 2.0 - 0.01, 0, 5.0], "X", 4.0, 4.0);
body + ears + bumper - box_centered(length - 6.0, 1.5, 10.0).translate([0, 0, 0])
