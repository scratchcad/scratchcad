// Cast aluminium LB conduit body for 3/4 in (21 mm) conduit: 115 x 40 x 38 mm body, threaded hubs at one end and in the back, 2.5 mm walls, cover opening with two screw bosses
let length = 115.0; // [80.0, 160.0] Body length (mm)
let width = 40.0; // [30.0, 60.0] Body width (mm)
let depth = 38.0; // [28.0, 55.0] Body depth (mm)
let hub_d = 33.0; // [25.0, 45.0] Hub outside diameter (mm)
let bore = 22.0; // [16.0, 35.0] Conduit bore (mm)
const wall = 2.5;
let bd = min(bore, min(hub_d, width) - 5.0);
let hl = length / 2.0;
let body = box_centered(length, width, depth).translate([0, 0, depth / 2.0]).fillet(width / 2.0 - 0.5, "|Z").fillet(3.0, "<Z");
let cavity = box_centered(length - 2.0 * wall, width - 2.0 * wall, depth).translate([0, 0, depth / 2.0 + wall]).fillet(width / 2.0 - wall - 0.5, "|Z");
let hub_end = cylinder([hl - 5.0, 0, depth / 2.0], "X", hub_d / 2.0, 20.0);
let hub_back = cylinder([-hl + hub_d / 2.0 + 2.0, 0, -18.0], "Z", hub_d / 2.0, 20.0);
let lb = fuse_all([body, hub_end, hub_back]) - cavity;
lb -= cylinder([hl - 10.0, 0, depth / 2.0], "X", bd / 2.0, 30.0);
lb -= cylinder([-hl + hub_d / 2.0 + 2.0, 0, -20.0], "Z", bd / 2.0, 25.0);
let bosses = [];
for s in [-1.0, 1.0] { bosses.push(cylinder([s * (hl - 4.0), 0, wall], "Z", 3.5, depth - wall - 1.5) - cylinder([s * (hl - 4.0), 0, 10.0], "Z", 1.4, depth)); }
lb + fuse_all(bosses)
