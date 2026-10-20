// Arcade game token: 25 mm coin 2.2 mm thick with a raised 1 mm rim, faces recessed 0.3 mm inside the rim with a raised star standing flush with the rim on both faces and a reeded edge of 60 grooves
let dia = 25.0; // [18.0, 32.0] Token diameter (mm)
let grooves = 60; // [0, 120] Number of edge reeds
const t = 2.2;
let c = cylinder([0, 0, 0], "Z", dia / 2.0, t) - (cylinder([0, 0, t - 0.3], "Z", dia / 2.0 - 1.0, 1.0)) - (cylinder([0, 0, -0.7], "Z", dia / 2.0 - 1.0, 1.0));
let pts = [];
for i in 0..10 { let a = (90.0 + 36.0 * i.to_float()) * PI() / 180.0; let rr = if i % 2 == 0 { dia * 0.3 } else { dia * 0.12 }; pts.push([rr * cos(a), rr * sin(a), 0]); }
let star = face(polygon(pts)).extrude([0, 0, t - 0.6]).translate([0, 0, 0.3]);
let reeds = [];
for i in 0..grooves { reeds.push(box_centered(0.4, 0.4, t + 2.0).translate([dia / 2.0, 0, t / 2.0]).rotate_z(i.to_float() * 360.0 / grooves.to_float())); }
if grooves > 0 { c + star - fuse_all(reeds) } else { c + star }
