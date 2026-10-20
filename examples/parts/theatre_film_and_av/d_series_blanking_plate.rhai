// D-series blanking plate: 26 x 31 mm flange 2 mm thick with a 23.6 mm spigot 3 mm deep to plug an unused 24 mm D-series hole, two 3.2 mm holes at 19 x 24 mm diagonal corners
let width = 26.0; // [24.0, 30.0] Flange width (mm)
let height = 31.0; // [28.0, 36.0] Flange height (mm)
let thickness = 2.0; // [1.5, 3.0] Flange thickness (mm)
let spigot = 23.6; // [22.0, 24.0] Spigot diameter (mm)
let f = box_centered(width, height, thickness).translate([0, 0, thickness / 2.0]);
let fl = f.fillet(2.0, f.edges("|Z")).chamfer(0.4, ">Z");
let s = cylinder([0, 0, -3.0], "Z", spigot / 2.0, 3.01) - cylinder([0, 0, -4.0], "Z", spigot / 2.0 - 1.5, 3.5);
(fl + s) - cylinder([-9.5, 12.0, -5.0], "Z", 1.6, 10.0) - cylinder([9.5, -12.0, -5.0], "Z", 1.6, 10.0)
