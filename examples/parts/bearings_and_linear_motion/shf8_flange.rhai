// SHF8 shaft flange support: 43 x 10 mm base plate, 8 mm shaft boss 20 mm tall, 4 M4 holes on 32 mm
let plate = 43.0; // [32.0, 60.0] Flange width (mm)
let plate_t = 5.0; // [4.0, 10.0] Flange thickness (mm)
let boss_d = 20.0; // [14.0, 30.0] Boss diameter (mm)
let boss_h = 20.0; // [12.0, 30.0] Overall height (mm)
let shaft_d = 8.0; // [6.0, 16.0] Shaft diameter (mm)
let flange = cylinder(plate / 2.0, plate_t) & box_centered(plate, boss_d + 4.0, 20.0);
let part = flange + cylinder(boss_d / 2.0, boss_h);
part = part - cylinder([0, 0, -1], "Z", shaft_d / 2.0, boss_h + 2.0);
for s in [-1, 1] { part -= cylinder([s * 16.0, 0, -1], "Z", 2.25, plate_t + 2.0); }
part - cylinder([0, -boss_d, boss_h - 5.0], "Y", 1.5, boss_d * 2.0)
