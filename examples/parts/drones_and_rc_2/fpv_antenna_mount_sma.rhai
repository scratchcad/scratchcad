// FPV antenna mount for 30.5 mm stacks: SMA 6.5 mm hole at 45 degrees, 2 standoff clamps 5 mm, 35 x 15 x 3 mm
let spacing = 30.5; // [20.0, 30.5] Standoff spacing (mm)
let standoff = 5.0; // [4.0, 6.0] Standoff diameter (mm)
let plate = box_centered(spacing + 10.0, 15.0, 3.0).translate([0, 0, 1.5]);
let clamps = [];
for s in [-1.0, 1.0] { clamps.push(cylinder([s * spacing / 2.0, 0, 0], "Z", standoff / 2.0 + 2.0, 10.0) - cylinder([s * spacing / 2.0, 0, -1], "Z", standoff / 2.0, 12.0) - box_from_corners([s * spacing / 2.0 - 0.5, -10.0, -1], [s * spacing / 2.0 + 0.5, 0, 11.0])); }
let boss = cylinder([0, 0, 0], "Z", 6.0, 14.0).rotate_x(-45.0).translate([0, 2.0, 2.0]);
let hole = cylinder([0, 0, -5.0], "Z", 3.25, 25.0).rotate_x(-45.0).translate([0, 2.0, 2.0]);
((plate + fuse_all(clamps) + boss) & box_from_corners([-50, -30, 0], [50, 30, 30])) - hole - cylinder([-spacing / 2.0, 0, -1], "Z", standoff / 2.0, 12.0) - cylinder([spacing / 2.0, 0, -1], "Z", standoff / 2.0, 12.0)
