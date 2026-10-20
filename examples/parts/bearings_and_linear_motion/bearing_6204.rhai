// 6204 deep groove ball bearing: 20 x 47 x 14 mm, 8 balls of 7.94 mm, races with ball grooves
let bore = 20.0; // [10.0, 30.0] Bore (mm)
let outer = 47.0; // [30.0, 62.0] Outside diameter (mm)
let width = 14.0; // [9.0, 16.0] Width (mm)
let ball_d = 7.94; // [5.0, 10.0] Ball diameter (mm)
let balls = 8; // [6, 12] Number of balls
let pitch_r = (bore + outer) / 4.0;
let groove = torus(pitch_r, ball_d / 2.0 + 0.05).translate([0, 0, width / 2.0]);
let inner = (cylinder(pitch_r - ball_d * 0.3, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0) - groove).chamfer(0.6, "%CIRCLE and (>Z or <Z)");
let outer_ring = (cylinder(outer / 2.0, width) - cylinder([0, 0, -1], "Z", pitch_r + ball_d * 0.3, width + 2.0) - groove).chamfer(0.6, "%CIRCLE and (>Z or <Z)");
let parts = [inner, outer_ring];
for i in 0..balls { parts.push(sphere([pitch_r, 0, width / 2.0], ball_d / 2.0).rotate_z(i * 360.0 / balls.to_float())); }
compound(parts)
