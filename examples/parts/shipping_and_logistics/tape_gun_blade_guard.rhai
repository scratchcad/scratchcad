// Tape gun blade guard: 50 mm tape width, 55 x 12 x 6 mm cap with a 1 mm blade slot 4 mm deep and snap lips
let tape = 50.0; // [25.0, 75.0] Tape width (mm)
let g = box_centered(tape + 5.0, 12.0, 6.0).translate([0, 0, 3.0]);
let gg = g.fillet(2.0, g.edges("|X and >Z"));
let slot = box_centered(tape + 1.0, 1.2, 8.0);
let lips = box_centered(tape + 5.0, 1.0, 2.0).translate([0, 4.5, -0.99]) + box_centered(tape + 5.0, 1.0, 2.0).translate([0, -4.5, -0.99]);
gg - slot + lips
