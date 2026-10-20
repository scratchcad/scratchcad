// Clamp-on matte box adapter ring from 114 mm to an 80 mm lens: 114 mm OD 15 mm long with a 1 mm chamfer, 80.2 mm bore, 3 mm front lip down to 76 mm, and three M4 nylon thumb-screw holes (3.3 mm) at 120 degrees
let outer_d = 114.0; // [95.0, 130.0] Matte box size (mm)
let lens_d = 80.0; // [50.0, 85.0] Lens front diameter (mm)
let length = 15.0; // [10.0, 25.0] Ring length (mm)
let ro = outer_d / 2.0;
let rb = lens_d / 2.0 + 0.1;
let rl = rb - 2.0;
let ring = face(polygon([
    [rl, 0, 0], [ro - 1.0, 0, 0], [ro, 0, 1.0], [ro, 0, length - 1.0], [ro - 1.0, 0, length],
    [rb, 0, length], [rb, 0, 3.0], [rl, 0, 3.0]])).revolve("Z", 360.0);
let screws = [];
for i in 0..3 {
    screws.push(cylinder([rb - 1.0, 0, (length + 3.0) / 2.0], "X", 1.65, ro - rb + 3.0).rotate_z(i.to_float() * 120.0 + 90.0));
}
ring - fuse_all(screws)
