// Pour-over dripper, size 02: 60 degree cone 116 mm top ID, 2 mm wall, 14 spiral-style ribs, 20 mm exit hole, 100 mm flange
let top = 116.0; // [90.0, 140.0] Top inside diameter (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let exit = 20.0; // [10.0, 25.0] Exit hole (mm)
let h = (top / 2.0 - exit / 2.0) / (30.0 * PI() / 180.0).tan();
let outer = cone(exit / 2.0 + wall, top / 2.0 + wall, h).translate([0, 0, 10.0]);
let inner = cone(exit / 2.0, top / 2.0, h + 0.02).translate([0, 0, 10.0 + wall * 0.5 - 0.01]);
let ribs = [];
for k in 0..14 { ribs.push(box_from_corners([0, -0.6, 0], [top / 2.0, 0.6, 1.2]).rotate_y(-60.0).translate([exit / 2.0 + 1.0, 0, 12.0]).rotate_z(k.to_float() * 360.0 / 14.0)); }
let base = cylinder(50.0, 4.0) + cylinder([0, 0, 3.99], "Z", exit / 2.0 + wall + 3.0, 6.02);
(outer - inner + (fuse_all(ribs) & outer)) + base - cylinder([0, 0, -1], "Z", exit / 2.0, 20.0)
