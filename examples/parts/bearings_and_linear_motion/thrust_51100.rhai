// 51100 thrust ball bearing: 10 mm bore, 24 mm OD, 9 mm tall, two washers and a ball cage of 10 balls
let bore = 10.0; // [6.0, 30.0] Bore (mm)
let outer = 24.0; // [16.0, 52.0] Outside diameter (mm)
let height = 9.0; // [6.0, 18.0] Height (mm)
let balls = 10; // [6, 18] Number of balls
let ball_d = height * 0.45;
let washer_t = (height - ball_d) / 2.0 + ball_d * 0.2;
let pitch_r = (bore + outer) / 4.0;
let race = torus(pitch_r, ball_d / 2.0 + 0.05).translate([0, 0, height / 2.0]);
let shaft_washer = (cylinder(outer / 2.0 - 0.3, washer_t) - cylinder([0, 0, -1], "Z", bore / 2.0, washer_t + 2.0)) - race;
let housing_washer = (cylinder([0, 0, height - washer_t], "Z", outer / 2.0, washer_t) - cylinder([0, 0, height - washer_t - 1], "Z", bore / 2.0 + 0.2, washer_t + 2.0)) - race;
let parts = [shaft_washer, housing_washer];
for i in 0..balls { parts.push(sphere([pitch_r, 0, height / 2.0], ball_d / 2.0).rotate_z(i * 360.0 / balls.to_float())); }
compound(parts)
