// Blocky toy robot figure 80 mm tall: box torso with chest panel, head with antenna and eyes, arms and legs as pegged blocks
let h = 80.0; // [50.0, 150.0] Height (mm)
let s = h / 80.0;
let parts = [
    box_centered(30.0, 18.0, 30.0).translate([0, 0, 45.0]),
    box_centered(20.0, 16.0, 16.0).translate([0, 0, 69.0]).fillet(2.0, "|Y"),
    cylinder([0, 0, 76.9], "Z", 1.0, 6.0), sphere([0, 0, 83.0], 1.8),
    box_centered(9.0, 12.0, 30.0).translate([-7.0, 0, 15.0]), box_centered(9.0, 12.0, 30.0).translate([7.0, 0, 15.0]),
    box_centered(8.0, 10.0, 26.0).translate([-20.0, 0, 43.0]), box_centered(8.0, 10.0, 26.0).translate([20.0, 0, 43.0]),
    cylinder([-16.0, 0, 55.0], "X", 3.0, 32.0)
];
let bot = fuse_all(parts) - box_centered(16.0, 2.0, 12.0).translate([0, -9.0, 48.0]);
for x in [-5.0, 5.0] { bot -= cylinder([x, -9.0, 71.0], "Y", 2.0, 3.0); }
bot.scale(s)
