// KFL08 two-bolt rhombic flange bearing: 8 mm bore, 60 mm hole centers 48 mm, 13 mm thick, 28 mm boss
let centers = 48.0; // [36.0, 70.0] Bolt hole centers (mm)
let length = 60.0; // [45.0, 85.0] Overall length (mm)
let thickness = 5.0; // [4.0, 10.0] Flange thickness (mm)
let boss_d = 28.0; // [20.0, 40.0] Boss diameter (mm)
let boss_h = 13.0; // [8.0, 20.0] Overall height (mm)
let bore = 8.0; // [6.0, 20.0] Bore (mm)
let lobe = cylinder(6.5, thickness);
let rhomb = fuse_all([cylinder(boss_d / 2.0, thickness), lobe.translate([centers / 2.0, 0, 0]), lobe.translate([-centers / 2.0, 0, 0]),
    box_centered(centers, 13.0, thickness).translate([0, 0, thickness / 2.0])]);
let part = rhomb + (cylinder(boss_d / 2.0 - 2.0, boss_h) + sphere([0, 0, boss_h * 0.5], boss_d / 2.0 - 2.0)) & box_centered(80, 80, boss_h).translate([0, 0, boss_h / 2.0]);
part = part - cylinder([0, 0, -1], "Z", bore / 2.0, boss_h + 2.0);
for s in [-1, 1] { part -= cylinder([s * centers / 2.0, 0, -1], "Z", 2.5, thickness + 2.0); }
part
