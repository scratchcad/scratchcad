// SFU1204 ball screw nut: 24 mm body, 40 mm flange 10 mm thick with one flat, 6 x 4.5 mm holes on 32 mm, 40 mm long
let body_d = 24.0; // [18.0, 40.0] Body diameter (mm)
let flange_d = 40.0; // [30.0, 70.0] Flange diameter (mm)
let flange_t = 10.0; // [6.0, 15.0] Flange thickness (mm)
let length = 40.0; // [30.0, 60.0] Overall length (mm)
let pcd = 32.0; // [24.0, 55.0] Hole circle (mm)
let screw_d = 12.0; // [8.0, 25.0] Screw diameter (mm)
let flange = cylinder(flange_d / 2.0, flange_t) & box_centered(flange_d, flange_d, 50.0).translate([0, -flange_d / 2.0 + flange_d * 0.4 + 15.0, 0]);
let nut = flange + cylinder(body_d / 2.0, length);
for i in 0..6 { nut -= cylinder([pcd / 2.0, 0, -1], "Z", 2.25, flange_t + 2.0).rotate_z(i * 60.0 + 30.0); }
nut = nut - cylinder([0, 0, -1], "Z", screw_d / 2.0 - 0.5, length + 2.0);
nut - cylinder([0, 0, flange_t + 6.0], "X", 2.0, body_d)
