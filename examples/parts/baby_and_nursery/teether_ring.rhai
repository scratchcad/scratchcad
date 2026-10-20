// Flat teether ring: 70 mm OD, 40 mm ID, 10 mm thick, rounded edges, 8 bumps 4 mm on one face
let od = 70.0; // [50.0, 90.0] Outside diameter (mm)
let id = 40.0; // [25.0, 60.0] Inside diameter (mm)
let t = 10.0; // [7.0, 15.0] Thickness (mm)
let r = cylinder(od / 2.0, t) - cylinder([0, 0, -1], "Z", id / 2.0, t + 2.0);
let rr = r.fillet(3.0, r.edges("%CIRCLE"));
let bumps = [];
for k in 0..8 { let a = (k.to_float() * 45.0) * PI() / 180.0; bumps.push(sphere([(od + id) / 4.0 * a.cos(), (od + id) / 4.0 * a.sin(), t - 1.0], 3.0)); }
rr + fuse_all(bumps)
