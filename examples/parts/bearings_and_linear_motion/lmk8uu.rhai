// LMK8UU square-flange linear bearing: 15 mm body, 24 mm long, 25 mm square flange 5 mm thick, 4 x 3.5 mm holes on 32 mm PCD
let body_d = 15.0; // [10.0, 30.0] Body diameter (mm)
let length = 24.0; // [17.0, 45.0] Length (mm)
let flange = 25.0; // [18.0, 45.0] Flange width (mm)
let flange_t = 5.0; // [3.0, 8.0] Flange thickness (mm)
let bore = 8.0; // [6.0, 20.0] Bore (mm)
let pcd = 32.0; // [24.0, 50.0] Hole circle diameter (mm)
let part = box_centered(flange, flange, flange_t).translate([0, 0, flange_t / 2.0]).fillet(2.0, "|Z") + cylinder(body_d / 2.0, length);
for i in 0..4 { part -= cylinder([pcd / 2.0 * 0.7071, pcd / 2.0 * 0.7071, -1], "Z", 1.75, flange_t + 2.0).rotate_z(i * 90); }
part - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0)
