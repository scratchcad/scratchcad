// Swim fin heel strap buckle: 40 x 30 mm frame 5 mm thick for a 25 mm strap split by a 5 mm bar into two 5 mm slots, and a pivot ear with a 6 mm hole to mount on the fin foot pocket
let strap = 25.0; // [18.0, 35.0] Strap width (mm)
let t = 5.0; // [3.0, 7.0] Frame thickness (mm)
let w = strap + 10.0;
let frame = box_centered(w, 30.0, t).translate([0, 0, t / 2.0]);
let frame = frame.fillet(4.0, frame.edges("|Z"));
let slot = box_centered(strap + 1.0, 5.0, t + 2.0).translate([0, 6.0, t / 2.0]) + box_centered(strap + 1.0, 5.0, t + 2.0).translate([0, -4.0, t / 2.0]);
let boss = cylinder([-w / 2.0 - 3.0, -12.0, 0], "Z", 4.0, t) + box_from_corners([-w / 2.0 - 3.0, -16.0, 0], [-w / 2.0 + 1.0, -8.0, t]);
frame + boss - slot - cylinder([-w / 2.0 - 3.0, -12.0, -1.0], "Z", 3.0, t + 2.0)
