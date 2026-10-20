// SAE O-ring boss plug -06 (9/16-18 UNF): 14.3 mm thread stub 11 mm long, 0.9 mm O-ring groove at the hex face, 17.5 mm AF hex 6 mm thick with a 6 mm hex socket
let thread_d = 14.3; // [11.1, 22.2] Thread OD (mm)
let af = 17.5; // [14.0, 27.0] Hex across flats (mm)
let r = af / 2.0 / cos(PI() / 6.0);
let pts = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; pts.push([r * cos(a), r * sin(a), 0]); }
let hex = face(polygon(pts)).extrude([0, 0, 6.0]);
let stub = cylinder([0, 0, -11.0], "Z", thread_d / 2.0, 11.01);
let groove = cylinder([0, 0, -2.0], "Z", thread_d / 2.0 + 1.0, 1.8) - cylinder([0, 0, -3.0], "Z", thread_d / 2.0 - 1.2, 4.0);
let sr = 6.0 / 2.0 / cos(PI() / 6.0);
let sp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; sp.push([sr * cos(a), sr * sin(a), 0]); }
hex + stub - groove - face(polygon(sp)).extrude([0, 0, 5.0]).translate([0, 0, 2.0])
