// ANSI #25 roller chain sprocket, 17 teeth: 1/4 in pitch, 0.130 in rollers, 34.8 mm pitch dia, 2.8 mm thick, 6.35 mm bore
let teeth = 17; // [9, 60] Teeth
let pitch = 6.35; // [6.35, 25.4] Chain pitch (mm)
let roller_d = 3.3; // [3.3, 15.9] Roller diameter (mm)
let thickness = 2.8; // [2.0, 12.0] Tooth thickness (mm)
let bore = 6.35; // [3.0, 30.0] Bore (mm)
let pd = pitch / (PI() / teeth.to_float()).sin();
let od = pitch * (0.6 + 1.0 / (PI() / teeth.to_float()).tan());
let disk = cylinder(od / 2.0, thickness).chamfer(thickness * 0.3, "%CIRCLE and (>Z or <Z) and not (>Z[1] or <Z[1])");
let seats = [];
for i in 0..teeth { seats.push(cylinder([pd / 2.0, 0, -1], "Z", roller_d * 0.505, thickness + 2.0).rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
let flanks = [];
for i in 0..teeth { flanks.push(box_centered(od / 2.0 - pd / 2.0 + 2.0, roller_d * 1.01, thickness + 2.0).translate([pd / 2.0 + (od / 2.0 - pd / 2.0 + 2.0) / 2.0, 0, thickness / 2.0]).rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
disk - fuse_all(seats) - fuse_all(flanks) - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0)
