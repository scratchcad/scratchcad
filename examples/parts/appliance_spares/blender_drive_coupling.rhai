// Blender jar drive coupling: 30 mm 4-tooth star socket, 12 mm tall, 8 mm square-threaded hub bore 5/16-24 style
let diameter = 30.0; // [20.0, 45.0] Coupling diameter (mm)
let height = 12.0; // [8.0, 20.0] Height (mm)
let teeth = 4; // [3, 8] Number of drive teeth
let base = cylinder(diameter / 2.0, 4.0);
let lugs = [];
for k in 0..teeth { lugs.push(box_from_corners([4.0, -2.5, 3.99], [diameter / 2.0, 2.5, height]).rotate_z(k.to_float() * 360.0 / teeth.to_float())); }
let hub = cylinder([0, 0, 3.99], "Z", 6.5, height - 3.99);
base + fuse_all(lugs) + hub - cylinder([0, 0, -1], "Z", 3.9, height + 2.0)
