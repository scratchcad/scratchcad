// Cat toy ball track ring: 250 mm outer, 3-tier ring with a 45 mm ball channel open on top, 3 mm walls, 12 paw slots
let d = 250.0; // [180.0, 350.0] Outer diameter (mm)
let R = d / 2.0 - 25.0;
let ring = torus(R, 25.0) - torus(R, 22.0) - box_centered(d + 20.0, d + 20.0, 30.0).translate([0, 0, 15.0 + 10.0]);
let slots = [];
for k in 0..12 { slots.push(box_centered(30.0, 18.0, 40.0).translate([R, 0, 20.0]).rotate_z(k.to_float() * 30.0)); }
(ring - fuse_all(slots)) & box_centered(d + 10.0, d + 10.0, 60.0)
