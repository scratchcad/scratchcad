// Pedestal drawer recessed pull: 128 mm centers, 160 x 30 mm flange 3 mm, 20 mm deep finger pocket, 2 M4 bosses
let centers = 128.0; // [96.0, 192.0] Hole centers (mm)
let length = 160.0; // [120.0, 220.0] Flange length (mm)
let height = 30.0; // [20.0, 45.0] Flange height (mm)
let pocket = 20.0; // [12.0, 30.0] Pocket depth (mm)
let flange = box_centered(length, height, 3.0).translate([0, 0, 1.5]);
let f = flange.fillet(height / 2.0 - 0.5, flange.edges("|Z"));
let cup = box_centered(length - 20.0, height - 8.0, pocket).translate([0, 0, -pocket / 2.0 + 0.01]);
let cupi = box_centered(length - 24.0, height - 12.0, pocket).translate([0, 0, -pocket / 2.0 + 2.0]);
let bosses = cylinder([-centers / 2.0, 0, -pocket], "Z", 4.0, pocket) + cylinder([centers / 2.0, 0, -pocket], "Z", 4.0, pocket);
f + cup - cupi + (bosses - cylinder([-centers / 2.0, 0, -pocket - 1.0], "Z", 1.7, pocket) - cylinder([centers / 2.0, 0, -pocket - 1.0], "Z", 1.7, pocket))
