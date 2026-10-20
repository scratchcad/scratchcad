// Straight HVAC register boot, 4 x 10 in (102 x 254 mm) rectangular outlet to a 6 in (150 mm) round collar, 0.8 mm galvanized sheet, 20 mm nailing flange
let rect_w = 254.0; // [150.0, 356.0] Outlet length (mm)
let rect_d = 102.0; // [76.0, 152.0] Outlet width (mm)
let round_d = 150.0; // [100.0, 200.0] Collar diameter (mm)
let collar_len = 50.0; // [30.0, 80.0] Collar length (mm)
let transition = 100.0; // [60.0, 200.0] Transition height (mm)
let flange = 20.0; // [10.0, 30.0] Flange width (mm)
const wall = 0.8;
let r = round_d / 2.0;
let zt = collar_len + transition;
let outer = cylinder(r, collar_len) + loft([circle([0, 0, collar_len], "Z", r), rect(plane([0, 0, zt], "Z"), rect_w, rect_d)], true);
let inner = cylinder([0, 0, -1], "Z", r - wall, collar_len + 1.0)
    + loft([circle([0, 0, collar_len], "Z", r - wall), rect(plane([0, 0, zt + 0.5], "Z"), rect_w - 2.0 * wall, rect_d - 2.0 * wall)], true);
let shell = outer - inner;
let fl = box_centered(rect_w + 2.0 * flange, rect_d + 2.0 * flange, wall).translate([0, 0, zt - wall / 2.0])
    - box_centered(rect_w - 2.0 * wall, rect_d - 2.0 * wall, 4.0).translate([0, 0, zt]);
shell + fl
