// Wide-neck baby bottle collar: 60 mm ID ring 22 mm tall, 2 mm wall, 50 mm teat aperture, 24 grip ribs
let id = 60.0; // [45.0, 70.0] Thread inside diameter (mm)
let height = 22.0; // [15.0, 30.0] Height (mm)
let aperture = 50.0; // [30.0, 60.0] Teat aperture (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let ring = cylinder(id / 2.0 + wall, height) - cylinder([0, 0, -1], "Z", id / 2.0, height - 2.5 + 1.0) - cylinder([0, 0, -1], "Z", aperture / 2.0, height + 2.0);
let ribs = [];
for k in 0..24 { ribs.push(box_centered(1.0, 1.0, height - 6.0).translate([id / 2.0 + wall, 0, height / 2.0 - 1.0]).rotate_z(k.to_float() * 15.0)); }
let thread_lugs = [];
for k in 0..3 { thread_lugs.push(box_from_corners([id / 2.0 - 1.2, -6.0, 4.0 + k.to_float() * 4.0], [id / 2.0 + 0.01, 6.0, 5.5 + k.to_float() * 4.0]).rotate_z(k.to_float() * 120.0)); }
ring - compound(ribs) + fuse_all(thread_lugs)
