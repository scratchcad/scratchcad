// Resistance band door anchor: 60 x 40 mm paddle 8 mm thick that sits behind a closed door, with a 25 mm wide strap slot 4 mm and a 30 mm band loop eye
let paddle = 60.0; // [45.0, 90.0] Paddle length (mm)
let strap = 25.0; // [20.0, 40.0] Strap width (mm)
const t = 8.0;
let p = box_centered(paddle, strap + 15.0, t).translate([0, 0, t / 2.0]);
let p = p.fillet(6.0, p.edges("|Z"));
let p = p - box_centered(4.0, strap + 1.0, t + 2.0).translate([paddle / 2.0 - 10.0, 0, t / 2.0]);
let eye = cylinder([-paddle / 2.0 - 12.0, 0, 0], "Z", 17.0, t) - cylinder([-paddle / 2.0 - 12.0, 0, -1.0], "Z", 12.0, t + 2.0);
p + eye
