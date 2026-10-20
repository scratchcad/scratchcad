// Garden chair clip-on tube glide for 25 mm round tube: 40 x 30 mm pad 6 mm, 25 mm C-clip saddle 12 mm wide
let tube = 25.0; // [16.0, 32.0] Tube diameter (mm)
let length = 40.0; // [30.0, 60.0] Pad length (mm)
let width = 30.0; // [20.0, 40.0] Pad width (mm)
let pad = box_centered(length, width, 6.0).translate([0, 0, 3.0]);
let p = pad.fillet(8.0, pad.edges("|Z"));
let r = tube / 2.0;
let clip = cylinder([-length / 2.0, 0, 6.0 + r - 2.0], "X", r + 2.5, length) - cylinder([-length / 2.0 - 1.0, 0, 6.0 + r - 2.0], "X", r, length + 2.0) - box_from_corners([-length, -r * 0.75, 6.0 + r * 1.3], [length, r * 0.75, 6.0 + 2.0 * r + 5.0]);
p + (clip & box_from_corners([-length, -width, 5.99], [length, width, 50.0])) - cylinder([-length, 0, 6.0 + r - 2.0], "X", r, length * 2.0)
