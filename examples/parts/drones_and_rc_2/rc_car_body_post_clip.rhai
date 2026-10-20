// RC car body post with clip holes: 6 mm post 60 mm tall, 5 clip holes 1.2 mm every 5 mm from the top, M3 base thread 8 mm
let post = 6.0; // [4.0, 8.0] Post diameter (mm)
let height = 60.0; // [40.0, 90.0] Post height (mm)
let p = cylinder(post / 2.0, height) + cylinder([0, 0, -8.0], "Z", 1.5, 8.01);
let holes = [];
for k in 0..5 { holes.push(cylinder([-post, 0, height - 5.0 - k.to_float() * 5.0], "X", 0.6, post * 2.0)); }
p.chamfer(0.6, p.edges(">Z")) - compound(holes)
