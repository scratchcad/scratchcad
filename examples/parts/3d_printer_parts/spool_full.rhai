// 1 kg filament spool: 200 mm flanges 3 mm thick, 100 mm hub 65 mm wide, 53 mm centre hole, 4 lightening windows per flange
let flange_d = 200.0; // [150.0, 300.0] Flange diameter (mm)
let hub_d = 100.0; // [55.0, 150.0] Hub diameter (mm)
let width = 65.0; // [40.0, 100.0] Width between flanges (mm)
let bore = 53.0; // [30.0, 80.0] Centre hole (mm)
let t = 3.0;
let flange = cylinder(flange_d / 2.0, t) - cylinder([0, 0, -1], "Z", bore / 2.0, t + 2.0);
for i in 0..4 { flange -= cylinder([(hub_d + flange_d) / 4.0, 0, -1], "Z", (flange_d - hub_d) / 4.0 - 6.0, t + 2.0).rotate_z(i * 90 + 45); }
let hub = cylinder([0, 0, t - 0.01], "Z", hub_d / 2.0, width + 0.02) - cylinder([0, 0, 0], "Z", hub_d / 2.0 - 2.5, width + 2 * t);
let inner = cylinder([0, 0, t - 0.01], "Z", bore / 2.0 + 2.5, width + 0.02) - cylinder([0, 0, 0], "Z", bore / 2.0, width + 2 * t);
let ribs = [];
for i in 0..6 { ribs.push(box_from_corners([bore / 2.0 + 1.0, -1.0, t], [hub_d / 2.0 - 1.0, 1.0, t + width]).rotate_z(i * 60)); }
fuse_all([flange, flange.translate([0, 0, width + t]), hub, inner] + ribs)
