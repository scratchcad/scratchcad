// Spa jet eyeball: 35 mm sphere with a 10 mm nozzle bore and 4 directional fins, 50 mm escutcheon ring
let ball = 35.0; // [25.0, 45.0] Eyeball diameter (mm)
let nozzle = 10.0; // [6.0, 14.0] Nozzle bore (mm)
let ring = 50.0; // [40.0, 70.0] Escutcheon diameter (mm)
let b = sphere(ball / 2.0) & box_centered(ball + 2.0, ball + 2.0, ball * 0.7);
let esc = cylinder([0, 0, ball * 0.25], "Z", ring / 2.0, 4.0) - cylinder([0, 0, ball * 0.25 - 1.0], "Z", ball / 2.0 - 4.0, 6.0);
let e = esc.fillet(1.5, esc.edges(">Z"));
let fins = [];
for k in 0..4 { fins.push(box_centered(2.0, nozzle, ball * 0.3).translate([0, 0, ball * 0.2]).rotate_z(k.to_float() * 45.0)); }
b - cylinder([0, 0, -ball], "Z", nozzle / 2.0, ball * 2.0) + (fuse_all(fins) & cylinder([0, 0, -ball], "Z", nozzle / 2.0 + 0.5, ball * 2.0)) + (e & cylinder([0, 0, -ball], "Z", ring, ball * 2.0))
