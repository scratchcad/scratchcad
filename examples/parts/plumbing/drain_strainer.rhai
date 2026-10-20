// Sink drain strainer basket: 80 mm rim 3 mm thick, 60 mm basket 30 mm deep with 4 mm holes in rings, centre post
let rim_d = 80.0; // [60.0, 120.0] Rim diameter (mm)
let basket_d = 60.0; // [40.0, 100.0] Basket diameter (mm)
let depth = 30.0; // [15.0, 60.0] Depth (mm)
let hole_d = 4.0; // [2.0, 8.0] Hole diameter (mm)
let basket = (cone(basket_d / 2.0 - 4.0, basket_d / 2.0, depth).translate([0, 0, -depth]) + cylinder(rim_d / 2.0, 3.0)).shell(-1.5, ">Z");
let holes = [];
for k in 1..=2 { let r = (basket_d / 2.0 - 6.0) * k.to_float() / 2.0; let n = 8 * k; for i in 0..n { holes.push(cylinder([r, 0, -depth - 1.0], "Z", hole_d / 2.0, 4.0).rotate_z(i.to_float() * 360.0 / n.to_float())); } }
for i in 0..12 { holes.push(cylinder([0, 0, -depth * 0.5], "X", hole_d / 2.0, basket_d).rotate_z(i * 30)); }
basket - fuse_all(holes) + cylinder([0, 0, -depth], "Z", 4.0, depth + 15.0)
