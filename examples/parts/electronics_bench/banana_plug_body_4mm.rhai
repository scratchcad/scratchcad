// 4 mm banana plug shroud body: 10 mm grip 35 mm, 4 mm stackable rear socket, 5 mm cable exit, 8 grip ribs
let grip_d = 10.0; // [8.0, 14.0] Grip diameter (mm)
let length = 35.0; // [25.0, 50.0] Body length (mm)
let body = cylinder(grip_d / 2.0, length);
let b = body.chamfer(1.0, body.edges(">Z"));
let ribs = [];
for k in 0..8 { ribs.push(box_centered(1.0, 1.0, length - 14.0).translate([grip_d / 2.0, 0, length / 2.0 - 2.0]).rotate_z(k.to_float() * 45.0)); }
let side = cylinder([0, 0, length - 10.0], "X", 2.5, grip_d);
b - compound(ribs) - cylinder([0, 0, -1], "Z", 2.0, length - 4.0) - cylinder([0, 0, length - 12.0], "Z", 2.0, 13.0) - side
