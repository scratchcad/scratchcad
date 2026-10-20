// Violin practice mute: 3-prong comb 35 x 15 mm, 8 mm thick, with two 3 mm string slots 5 mm deep 11 mm apart and three 6 mm prongs that sit on the bridge, plus a 3 mm tether hole
let width = 35.0; // [28.0, 45.0] Mute width (mm)
let slot_gap = 11.0; // [9.0, 14.0] String slot spacing (mm)
const t = 8.0;
let body = box_centered(width, t, 15.0).translate([0, 0, 7.5]);
let body = body.fillet(3.0, body.edges("|Y and >Z"));
let slots = box_centered(3.0, t + 2.0, 6.0).translate([-slot_gap / 2.0, 0, 3.0 - 0.01]) + box_centered(3.0, t + 2.0, 6.0).translate([slot_gap / 2.0, 0, 3.0 - 0.01]);
body - slots - cylinder([-width, 0, 11.0], "X", 1.5, 2.0 * width)
