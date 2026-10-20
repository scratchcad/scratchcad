// 7200 angular contact ball bearing: 10 x 30 x 9 mm, 40 degree contact, outer ring relieved on one side
let bore = 10.0; // [8.0, 30.0] Bore (mm)
let outer = 30.0; // [22.0, 62.0] Outside diameter (mm)
let width = 9.0; // [7.0, 16.0] Width (mm)
let balls = 9; // [7, 14] Number of balls
let ball_d = (outer - bore) * 0.28;
let pitch_r = (bore + outer) / 4.0;
let groove = torus(pitch_r, ball_d / 2.0 + 0.05).translate([0, 0, width / 2.0]);
let inner = cylinder(pitch_r - ball_d * 0.25, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0) - groove;
let outer_ring = cylinder(outer / 2.0, width) - cylinder([0, 0, -1], "Z", pitch_r + ball_d * 0.25, width + 2.0) - groove
    - cone(pitch_r + ball_d * 0.45, pitch_r + ball_d * 0.25, width / 2.0).translate([0, 0, -0.01]);
let parts = [inner, outer_ring];
for i in 0..balls { parts.push(sphere([pitch_r, 0, width / 2.0], ball_d / 2.0).rotate_z(i * 360.0 / balls.to_float())); }
compound(parts)
