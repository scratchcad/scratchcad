// 58 mm portafilter dosing funnel: 58.5 mm ID collar 15 mm, 70 mm flared top 20 mm, 1.5 mm wall, 3 magnet bosses
let basket = 58.5; // [49.0, 59.0] Basket rim diameter (mm)
let collar = 15.0; // [8.0, 20.0] Collar depth (mm)
let flare = 70.0; // [62.0, 85.0] Top diameter (mm)
let wall = 1.5; // [1.2, 2.5] Wall (mm)
let c = cylinder(basket / 2.0 + wall, collar) - cylinder([0, 0, -1], "Z", basket / 2.0, collar + 2.0);
let f = cone(basket / 2.0 + wall, flare / 2.0 + wall, 20.0).translate([0, 0, collar - 0.01]) - cone(basket / 2.0, flare / 2.0, 20.02).translate([0, 0, collar - 0.02]);
let bosses = [];
for k in 0..3 { bosses.push(cylinder([basket / 2.0 + wall + 3.0, 0, 0], "Z", 4.5, 6.0).rotate_z(k.to_float() * 120.0) - cylinder([basket / 2.0 + wall + 3.0, 0, -1], "Z", 3.1, 4.0).rotate_z(k.to_float() * 120.0)); }
c + f + fuse_all(bosses)
