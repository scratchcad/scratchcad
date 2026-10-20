// Hand dryer drip tray: wall-mounted tray 300 x 100 mm and 25 mm deep with a 2.5 mm wall, a 1:20 fall to a 16 mm drain spigot 15 mm long at one end, 6 mm corner radii, and a 3 mm back flange 40 mm tall with three 5 mm screw holes
let length = 300.0; // [180.0, 400.0] Tray length (mm)
let depth = 100.0; // [60.0, 140.0] Tray depth (mm)
let tray_h = 25.0; // [15.0, 40.0] Tray height (mm)
let spigot_d = 16.0; // [10.0, 25.0] Drain spigot diameter (mm)
const wall = 2.5;
const flange_t = 3.0;
const flange_h = 40.0;
let outer = box_from_corners([-length / 2.0, 0, 0], [length / 2.0, depth, tray_h]);
let outer = outer.fillet(6.0, outer.edges("|Z"));
let fall = length / 20.0;
let ff = min(fall, tray_h - wall - 6.0);
let inner = box_from_corners([-length / 2.0 + wall, wall, wall], [length / 2.0 - wall, depth - wall, tray_h + 1.0]);
let inner = inner.fillet(3.5, inner.edges("|Z"));
let tray = outer - inner;
let wedge = face(polygon([[-length / 2.0 + wall - 0.5, 0, wall - 0.5], [length / 2.0 - wall + 0.5, 0, wall - 0.5], [length / 2.0 - wall + 0.5, 0, wall + ff]])).extrude([0, depth - 2.0 * wall + 1.0, 0]).translate([0, wall - 0.5, 0]);
let wedge = wedge & inner;
let sr = min(spigot_d / 2.0, depth / 4.0);
let sx = -length / 2.0 + wall + sr + 6.0;
let spigot = cylinder([sx, depth / 2.0, -15.0], "Z", sr, 15.5);
let flange = box_from_corners([-length / 2.0, -flange_t, 0], [length / 2.0, 0.5, flange_h]);
let flange = flange.fillet(5.0, flange.edges("|Y and >Z"));
let body = fuse_all([tray, wedge, spigot, flange]);
let cuts = [cylinder([sx, depth / 2.0, -16.0], "Z", sr - 2.0, 30.0)];
for x in [-length / 2.0 + 25.0, 0.0, length / 2.0 - 25.0] {
    cuts.push(cylinder([x, -flange_t - 1.0, flange_h - 10.0], "Y", 2.5, flange_t + 2.0));
}
(body - fuse_all(cuts)).mirror("XZ")
