// RC car body post: 6 mm post 80 mm tall with 6 clip holes 1.5 mm at 5 mm spacing near the top, a 10 mm mounting foot with an M3 tapped hole (2.5 mm) and a 1 mm tip chamfer
let height = 80.0; // [40.0, 120.0] Post height (mm)
let post = 6.0; // [5.0, 8.0] Post diameter (mm)
let p = cylinder([0, 0, 5.0], "Z", post / 2.0, height - 5.0) + cylinder([0, 0, 0], "Z", 5.0, 5.01);
let p = p.chamfer(1.0, p.edges(">Z"));
let holes = [cylinder([0, 0, -1.0], "Z", 1.25, 10.0)];
for i in 0..6 { holes.push(cylinder([-post, 0, height - 8.0 - i.to_float() * 5.0], "X", 0.75, 2.0 * post)); }
p - fuse_all(holes)
