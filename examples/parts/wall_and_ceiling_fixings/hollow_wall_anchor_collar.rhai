// Hollow wall anchor collar: 10 mm sleeve 30 mm long with a 16 mm x 1 mm collar, two anti-rotation teeth 2 mm and 4 slits 18 mm long forming the collapsing legs, 5 mm screw bore
let sleeve = 10.0; // [8.0, 14.0] Sleeve OD (mm)
let length = 30.0; // [20.0, 50.0] Sleeve length (mm)
const wall = 1.2;
let s = cylinder([0, 0, -length], "Z", sleeve / 2.0, length + 0.01) + cylinder([0, 0, 0], "Z", sleeve / 2.0 + 3.0, 1.0);
let teeth = box_from_corners([sleeve / 2.0 - 0.5, -0.5, -2.0], [sleeve / 2.0 + 0.5, 0.5, 0.01]) + box_from_corners([-sleeve / 2.0 - 0.5, -0.5, -2.0], [-sleeve / 2.0 + 0.5, 0.5, 0.01]);
let slits = [];
for i in 0..4 { slits.push(box_from_corners([0, -0.5, -length + 6.0], [sleeve, 0.5, -length + 24.0]).rotate_z(45.0 + 90.0 * i.to_float())); }
s + teeth - cylinder([0, 0, -length - 1.0], "Z", sleeve / 2.0 - wall, length + 3.0) - fuse_all(slits)
