// Glasses display stand: 60 x 50 mm base 5 mm thick with a 70 mm nose-bridge post 12 mm wide tilted back 10 degrees and a 20 mm saddle at the top for the bridge
let height = 70.0; // [50.0, 100.0] Post height (mm)
let tilt = 10.0; // [0.0, 20.0] Post tilt (degrees)
const t = 5.0;
let base = box_centered(60.0, 50.0, t).translate([0, 0, t / 2.0]);
let base = base.fillet(8.0, base.edges("|Z"));
let post = (box_centered(12.0, 6.0, height).translate([0, 0, height / 2.0]) + box_centered(20.0, 6.0, 8.0).translate([0, 0, height - 4.0]) - cylinder([0, -4.0, height + 3.0], "Y", 7.0, 8.0)).rotate_x(-tilt).translate([0, 0, t - 0.5]);
base + post
