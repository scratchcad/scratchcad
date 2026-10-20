// 608 deep-groove ball bearing, 8 x 22 x 7
let bore = 8.0; // [6.0, 10.0] Bore (mm)
let outer = 22.0; // [18.0, 26.0] Outside diameter (mm)
let width = 7.0; // [5.0, 9.0] Width (mm)
let ball_d = 3.97; // [3.0, 4.5] Ball diameter (mm)
let balls = 7; // [5, 10] Number of balls
let pitch_r = (bore + outer) / 4.0;
let mid = width / 2.0;
let groove = torus(pitch_r, ball_d / 2.0 + 0.02).translate([0, 0, mid]);
let inner = cylinder(pitch_r - 1.0, width) - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0);
let outer_ring = cylinder(outer / 2.0, width) - cylinder([0, 0, -1], "Z", pitch_r + 1.0, width + 2.0);
inner = (inner - groove).chamfer(0.3, "%CIRCLE and (>Z or <Z)");
outer_ring = (outer_ring - groove).chamfer(0.3, "%CIRCLE and (>Z or <Z)");
let parts = [inner, outer_ring];
for i in 0..balls {
    let a = i.to_float() * 360.0 / balls.to_float();
    parts.push(sphere([pitch_r, 0, mid], ball_d / 2.0).rotate_z(a));
}
compound(parts)
