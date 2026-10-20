// Ice hockey puck, regulation size: 76.2 mm (3 inch) diameter, 25.4 mm (1 inch) thick, with a knurled-style edge of 48 shallow grooves 0.5 mm deep and 0.5 mm edge chamfers
let dia = 76.2; // [60.0, 80.0] Puck diameter (mm)
let t = 25.4; // [15.0, 30.0] Puck thickness (mm)
let grooves = 48; // [0, 72] Number of edge grooves
let p = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let p = p.chamfer(0.5, p.edges("%CIRCLE"));
let g = [];
for i in 0..grooves { g.push(box_centered(1.0, 1.0, t - 6.0).translate([dia / 2.0, 0, t / 2.0]).rotate_z(i.to_float() * 360.0 / grooves.to_float())); }
if grooves > 0 { p - fuse_all(g) } else { p }
