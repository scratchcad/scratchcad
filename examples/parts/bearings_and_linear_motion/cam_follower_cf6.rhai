// CF6 cam follower (stud track roller): 16 mm roller 11 mm wide, M6 stud 16 mm long, 3 mm hex socket
let roller_d = 16.0; // [10.0, 40.0] Roller diameter (mm)
let roller_w = 11.0; // [7.0, 20.0] Roller width (mm)
let stud_d = 6.0; // [3.0, 16.0] Stud diameter (mm)
let stud_l = 16.0; // [8.0, 40.0] Stud length (mm)
let flange_d = 12.0; // [7.0, 30.0] Flange diameter (mm)
let roller = cylinder(roller_d / 2.0, roller_w).fillet(0.8, "%CIRCLE and (>Z or <Z) and not (>Z[1] or <Z[1])");
let roller_ring = roller - cylinder([0, 0, -1], "Z", roller_d * 0.3, roller_w + 2.0);
let stud = cylinder([0, 0, -stud_l], "Z", stud_d / 2.0, stud_l + roller_w * 0.5) + cylinder([0, 0, -0.6], "Z", flange_d / 2.0, 0.6) + cylinder([0, 0, -0.01], "Z", roller_d * 0.3 - 0.05, roller_w + 0.01);
let rc = 3.0 / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
[roller_ring, stud - polygon(pts).to_face().extrude(4.0).translate([0, 0, roller_w - 3.0])]
