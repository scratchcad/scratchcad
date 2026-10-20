// Writing aid ball grip: 45 mm foam-style ball that holds a pen or pencil up to 10 mm, pen bore 9.5 mm through at 20 degrees, flattened 30 mm base so it rests on the table, 3 shallow finger dimples
// # Ball
let ball_d = 45.0; // [35.0, 60.0] Ball diameter (mm)
let flat_d = 30.0; // [15.0, 40.0] Base flat diameter (mm)
// # Pen
let pen = 9.5; // [6.0, 12.0] Pen bore diameter (mm)
let tilt = 20.0; // [0.0, 35.0] Pen tilt (degrees)
let dimples = 3; // [0, 5] Number of finger dimples
let r = ball_d / 2.0;
let cut_h = r - (r * r - flat_d * flat_d / 4.0).sqrt();
let ball = sphere([0, 0, r - cut_h], r) - box_centered(ball_d * 2.0, ball_d * 2.0, ball_d).translate([0, 0, -ball_d / 2.0]);
let bore = cylinder([0, 0, -ball_d], "Z", pen / 2.0, ball_d * 3.0).rotate([0, 0, r - cut_h], "Y", tilt);
let ds = [];
for i in 0..dimples {
    ds.push(sphere([r + 3.0, 0, r - cut_h + 4.0], 6.5).rotate([0, 0, 0], "Z", 60.0 + i.to_float() * 120.0 / max(dimples - 1, 1).to_float()));
}
let part = ball - bore;
if dimples > 0 { part - fuse_all(ds) } else { part }
