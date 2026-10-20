// RC tyre gluing ring: 1/10 scale 52 mm wheel holder, 60 mm OD 8 mm tall ring with a 52.5 mm seat 5 mm deep and four rubber-band notches
let wheel = 52.0; // [40.0, 70.0] Wheel rim diameter (mm)
let height = 8.0; // [5.0, 12.0] Ring height (mm)
let r = wheel / 2.0 + 0.25;
let ring = cylinder([0, 0, 0], "Z", r + 4.0, height) - cylinder([0, 0, height - 5.0], "Z", r, 6.0) - cylinder([0, 0, -1.0], "Z", r - 3.0, height + 2.0);
let notches = [];
for i in 0..4 { notches.push(box_centered(3.0, 10.0, 3.0).translate([0, r + 4.0, height - 1.5 + 0.01]).rotate_z(i.to_float() * 90.0)); }
ring - fuse_all(notches)
