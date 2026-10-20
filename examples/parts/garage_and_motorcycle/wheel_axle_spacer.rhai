// Motorcycle rear wheel axle spacer: 25 mm OD x 20.2 mm bore (20 mm axle), 32 mm long, 30 mm x 3 mm seal flange, chamfered ends
let outer_d = 25.0; // [20.0, 35.0] Outer diameter (mm)
let bore_d = 20.2; // [12.2, 25.2] Bore (mm)
let length = 32.0; // [10.0, 60.0] Length (mm)
let flange_d = 30.0; // [25.0, 40.0] Flange diameter (mm)
let flange_t = 3.0; // [1.0, 6.0] Flange thickness (mm)
let bd = min(bore_d, outer_d - 3.0);
let fd = max(flange_d, outer_d + 1.0);
let sp = cylinder(outer_d / 2.0, length) + cylinder(fd / 2.0, flange_t);
sp = sp - cylinder([0, 0, -1.0], "Z", bd / 2.0, length + 2.0);
sp.chamfer(0.6, sp.edges("%CIRCLE").filter(|e| e.radius() > bd / 2.0 + 0.1 && (e.center().z > length - 0.1 || e.center().z < 0.1)))
