// Fixed shower head: 100 mm face 4 mm thick with 37 spray nozzles, conical back 30 mm deep, 1/2 in inlet stub
let face_d = 100.0; // [60.0, 250.0] Face diameter (mm)
let depth = 30.0; // [15.0, 60.0] Body depth (mm)
let rings = 3; // [1, 6] Nozzle rings
let body = cone(face_d / 2.0, 12.0, depth).fillet(3.0, "<Z") + cylinder([0, 0, depth - 0.01], "Z", 10.5, 15.0);
body = body.shell(-2.5, ">Z");
let nozzles = [cylinder([0, 0, -1], "Z", 1.2, 4.0)];
for k in 1..=rings { let r = face_d / 2.0 * 0.8 * k.to_float() / rings.to_float(); let n = 6 * k * 2; for i in 0..n { nozzles.push(cylinder([r, 0, -1], "Z", 0.8, 4.0).rotate_z(i.to_float() * 360.0 / n.to_float())); } }
body - fuse_all(nozzles)
