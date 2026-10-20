// 150 mm try square: 30 x 2 mm steel blade with 10 mm graduations set into a 100 x 14 x 14 mm stock with three brass rivets
let blade_len = 150.0; // [100.0, 300.0] Blade length (mm)
let blade = box_from_corners([-8.0, 0, 0], [blade_len, 30.0, 2.0]);
let n = (blade_len / 10.0).to_int();
for k in 1..n { blade -= box_centered(0.4, if k % 5 == 0 { 8.0 } else { 5.0 }, 0.6).translate([k.to_float() * 10.0, 30.0 - 2.0, 2.0]); }
let stock = box_from_corners([-14.0, 0, -6.0], [0, 100.0, 8.0]).fillet(1.0, "|Z");
let rivets = [];
for y in [15.0, 50.0, 85.0] { rivets.push(cylinder([-7.0, y, -6.5], "Z", 3.0, 15.0)); }
fuse_all([stock, blade] + rivets)
