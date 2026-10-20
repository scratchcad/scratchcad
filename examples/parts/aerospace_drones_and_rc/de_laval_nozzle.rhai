// De Laval nozzle: 30 mm chamber bore, 45 deg convergence to a 10 mm throat, 15 deg cone to a 28 mm exit, 2.5 mm wall, 6-bolt flange
let throat = 10.0; // [4.0, 20.0] Throat diameter (mm)
let exit = 28.0; // [12.0, 60.0] Exit diameter (mm)
let wall = 2.5; // [1.5, 5.0] Wall thickness (mm)
let rt = throat / 2.0;
let zt = 10.0 + (15.0 - rt);
let ze = zt + 2.0 + (exit / 2.0 - rt) / (15.0 * PI() / 180.0).tan();
let inner = [[15.0, 0, 0], [15.0, 0, 10.0], [rt + 1.0, 0, zt - 1.0], [rt, 0, zt + 1.0], [rt + 0.3, 0, zt + 2.0], [exit / 2.0, 0, ze]];
let outer = [];
for p in inner { outer.push([p[0] + wall, 0, p[2]]); }
outer.reverse();
let body = polygon(inner + outer).to_face().revolve("Z", 360);
let flange = cylinder(25.0, 5.0) - cylinder([0, 0, -1], "Z", 15.0, 7.0);
for k in 0..6 { flange -= cylinder([21.0, 0, -1], "Z", 1.7, 7.0).rotate("Z", k.to_float() * 60.0); }
body + flange
