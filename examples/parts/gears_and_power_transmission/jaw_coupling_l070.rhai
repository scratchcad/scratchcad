// L-070 jaw coupling half: 35 mm OD, 3 jaws 12.7 mm tall, 12 mm bore with M5 set screw, plus the 6-arm spider
let outer_d = 35.0; // [25.0, 65.0] Outside diameter (mm)
let hub_l = 15.0; // [10.0, 30.0] Hub length (mm)
let jaw_h = 12.7; // [8.0, 20.0] Jaw height (mm)
let bore = 12.0; // [5.0, 30.0] Bore (mm)
let hub = cylinder(outer_d / 2.0, hub_l);
let jaw = (cylinder([0, 0, hub_l - 0.01], "Z", outer_d / 2.0, jaw_h) - cylinder([0, 0, hub_l - 1], "Z", outer_d * 0.22, jaw_h + 2)) & box_from_corners([0, 0, 0], [outer_d, outer_d, 50]).rotate_z(-15);
let jaw = jaw & box_from_corners([0, -outer_d, 0], [outer_d, 0, 50]).rotate_z(75);
let half = fuse_all([hub, jaw, jaw.rotate_z(120), jaw.rotate_z(240)]);
half = half - cylinder([0, 0, -1], "Z", bore / 2.0, hub_l + jaw_h + 2) - cylinder([0, 0, hub_l / 2.0], "X", 2.1, outer_d);
let arm = (cylinder(outer_d / 2.0 - 1.0, jaw_h - 1.0) - cylinder([0, 0, -1], "Z", outer_d * 0.22, jaw_h + 1.0)) & box_centered(outer_d, 5.0, jaw_h * 2.0).translate([outer_d / 2.0, 0, 0]);
let spider = fuse_all([cylinder(outer_d * 0.24, jaw_h - 1.0) - cylinder([0, 0, -1], "Z", outer_d * 0.15, jaw_h + 1), arm, arm.rotate_z(60), arm.rotate_z(120), arm.rotate_z(180), arm.rotate_z(240), arm.rotate_z(300)]);
[half, spider.translate([0, 0, hub_l + jaw_h + 5.0])]
