// Oldham coupling: two 25 mm hubs with 5 mm tongues and a center disk with crossed slots, 8 mm bores
let outer_d = 25.0; // [16.0, 60.0] Outside diameter (mm)
let hub_l = 12.0; // [6.0, 30.0] Hub length (mm)
let tongue_w = 5.0; // [3.0, 12.0] Tongue width (mm)
let tongue_h = 3.0; // [2.0, 8.0] Tongue height (mm)
let bore = 8.0; // [4.0, 20.0] Bore (mm)
let hub = cylinder(outer_d / 2.0, hub_l) + (box_centered(tongue_w, outer_d, tongue_h).translate([0, 0, hub_l + tongue_h / 2.0 - 0.01]) & cylinder(outer_d / 2.0, 60));
hub = hub - cylinder([0, 0, -1], "Z", bore / 2.0, hub_l + tongue_h + 2.0);
let disk_t = 2.0 * tongue_h + 2.0;
let disk = cylinder(outer_d / 2.0, disk_t) - box_centered(tongue_w + 0.2, outer_d + 2, tongue_h * 2.0).translate([0, 0, 0]) - box_centered(outer_d + 2, tongue_w + 0.2, tongue_h * 2.0).translate([0, 0, disk_t]);
[hub, disk.translate([0, 0, hub_l + 0.2]), hub.rotate_x(180).rotate_z(90).translate([0, 0, 2.0 * hub_l + disk_t + 0.4])]
