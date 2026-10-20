// Glaze dipping tong jaw tip: 3 point claw 30 mm, fits a 6 mm steel rod 25 mm socket
let rod = 6.0; // [4.0, 8.0] Rod diameter (mm)
let socket = cylinder(rod / 2.0 + 2.5, 25.0) - cylinder([0, 0, -1], "Z", rod / 2.0 + 0.1, 24.0);
let claws = [];
for k in 0..3 { claws.push(cone(2.5, 0.5, 30.0).rotate_y(25.0).translate([0, 0, 24.0]).rotate_z(k.to_float() * 120.0)); }
socket + fuse_all(claws)
