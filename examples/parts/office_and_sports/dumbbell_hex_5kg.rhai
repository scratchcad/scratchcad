// 5 kg hex dumbbell: two hexagonal heads 110 mm across corners 50 mm wide, 32 mm knurled handle 130 mm long
let head_w = 50.0; // [30.0, 80.0] Head width (mm)
let grip = 130.0; // [100.0, 150.0] Handle length (mm)
const rc = 55.0;
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let head = polygon(hp).to_face().extrude(head_w).chamfer(2.0, ">Z or <Z").rotate_y(90.0);
let handle = cylinder([-1.0, 0, 0], "X", 16.0, grip + 2.0);
for k in 0..10 { handle -= torus(16.0, 0.6).rotate_y(90.0).translate([15.0 + k.to_float() * 10.0, 0, 0]); }
fuse_all([head.translate([-head_w, 0, 0]), handle, head.translate([grip, 0, 0])])
