// Raspberry Pi Zero case base: 65 x 30 mm board, 1.5 mm walls, 8 mm tall, M2.5 posts on 58 x 23 mm, slots for mini HDMI and 2 micro USB
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let clearance = 0.5; // [0.2, 1.5] Clearance (mm)
let height = 8.0; // [5.0, 20.0] Height (mm)
let ow = 65.0 + 2.0 * (wall + clearance); let oh = 30.0 + 2.0 * (wall + clearance);
let base = box(ow, oh, height).fillet(3.0, "|Z") - box_from_corners([wall, wall, wall], [ow - wall, oh - wall, height + 1]);
let x0 = wall + clearance; let y0 = wall + clearance;
for x in [3.5, 61.5] { for y in [3.5, 26.5] {
    base = base + (cylinder([x0 + x, y0 + y, wall - 0.1], "Z", 2.5, 2.6) - cylinder([x0 + x, y0 + y, wall], "Z", 1.1, 3.0));
} }
let z = wall + 2.5;
let cuts = [box_centered(12.0, wall * 3.0, 4.0).translate([x0 + 12.4, wall / 2.0, z + 2.0]),
            box_centered(8.5, wall * 3.0, 3.5).translate([x0 + 41.4, wall / 2.0, z + 1.75]),
            box_centered(8.5, wall * 3.0, 3.5).translate([x0 + 54.0, wall / 2.0, z + 1.75])];
base - fuse_all(cuts)
