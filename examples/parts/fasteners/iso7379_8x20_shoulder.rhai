// ISO 7379 shoulder screw 8 mm shoulder x 20 mm, M6 thread 9.5 mm, 13 mm head, 4 mm hex
let shoulder_d = 8.0; // [5.0, 20.0] Shoulder diameter (mm)
let shoulder_l = 20.0; // [6.0, 80.0] Shoulder length (mm)
let head_d = 13.0; // [8.0, 30.0] Head diameter (mm)
let head_h = 5.5; // [3.5, 14.0] Head height (mm)
let thread_d = 6.0; // [4.0, 16.0] Thread diameter (mm)
let thread_l = 9.5; // [6.0, 30.0] Thread length (mm)
let socket = 4.0; // [2.5, 10.0] Hex key size (mm)
let head = cylinder([0, 0, shoulder_l], "Z", head_d / 2.0, head_h).chamfer(0.5, ">Z");
let rc = socket / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts).to_face().extrude(head_h).translate([0, 0, shoulder_l + head_h * 0.4]);
let undercut = cylinder([0, 0, -0.01], "Z", thread_d / 2.0 - 0.3, 1.2);
fuse_all([head - hex, cylinder(shoulder_d / 2.0, shoulder_l + 0.01), cylinder([0, 0, -thread_l], "Z", thread_d / 2.0, thread_l + 0.01), undercut]).chamfer(0.4, "<Z")
