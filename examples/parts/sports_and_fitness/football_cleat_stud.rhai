// Screw-in football boot stud: 20 mm base washer 2 mm, 15 mm tapering to 10 mm cone 13 mm tall with a rounded tip, 5 mm threaded stub 7 mm long, two 2 mm spanner holes 6 mm apart in the tip
let base_d = 20.0; // [15.0, 25.0] Base washer diameter (mm)
let stud_d = 15.0; // [12.0, 18.0] Stud diameter at the base (mm)
let tip_d = 10.0; // [6.0, 14.0] Tip diameter (mm)
let stud_height = 13.0; // [8.0, 20.0] Stud height (mm)
let thread_d = 5.0; // [4.0, 8.0] Thread stub diameter (mm)
const thread_len = 7.0;
let td = min(tip_d, stud_d);
let base = cylinder(base_d / 2.0, 2.0).chamfer(0.5, ">Z");
let stud = cone(stud_d / 2.0, td / 2.0, stud_height).translate([0, 0, 1.99]);
stud = stud.fillet(1.0, ">Z");
let threads = [cylinder([0, 0, -thread_len], "Z", thread_d / 2.0 - 0.4, thread_len + 0.5)];
for i in 0..5 { threads.push(cone(thread_d / 2.0 - 0.4, thread_d / 2.0, 0.4).translate([0, 0, -thread_len + 0.8 + i.to_float() * 1.2])); }
let cleat = fuse_all([base, stud] + threads);
for x in [-3.0, 3.0] { cleat = cleat - cylinder([x, 0, stud_height + 2.0 - 3.0], "Z", 1.0, 4.0); }
cleat
