// ISO-A 1/2 in hydraulic coupler dust cap: 30 mm bore 25 mm deep, 2.5 mm wall, 8 grip ribs, tether loop
let bore = 30.0; // [20.0, 40.0] Coupler OD (mm)
let depth = 25.0; // [15.0, 35.0] Cap depth (mm)
let wall = 2.5; // [2.0, 4.0] Wall (mm)
let c = cylinder(bore / 2.0 + wall, depth + wall) - cylinder([0, 0, -1], "Z", bore / 2.0, depth + 1.0);
let ribs = [];
for k in 0..8 { ribs.push(box_centered(2.0, 2.0, depth - 4.0).translate([bore / 2.0 + wall, 0, depth / 2.0]).rotate_z(k.to_float() * 45.0)); }
let loop_ = cylinder([bore / 2.0 + wall + 4.0, -1.5, 5.0], "Y", 5.0, 3.0) - cylinder([bore / 2.0 + wall + 4.0, -2.0, 5.0], "Y", 2.5, 4.0);
c + compound(ribs) + loop_
