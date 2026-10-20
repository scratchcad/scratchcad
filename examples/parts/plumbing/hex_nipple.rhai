// 1/2 in BSP hex nipple: 21 mm threads 12 mm each side of a 24 mm hex 8 mm long, 15 mm bore
let thread_d = 20.95; // [13.0, 48.0] Thread diameter (mm)
let thread_l = 12.0; // [8.0, 25.0] Thread length (mm)
let hex = 24.0; // [16.0, 55.0] Hex size (mm)
let bore = 15.0; // [8.0, 20.4] Bore (mm)
let rc = hex / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let h = polygon(pts).to_face().extrude(8.0).chamfer(0.8, "not |Z");
let part = fuse_all([h, cylinder([0, 0, -thread_l], "Z", thread_d / 2.0, thread_l + 0.01), cylinder([0, 0, 7.99], "Z", thread_d / 2.0, thread_l + 0.01)]);
let grooves = [];
for k in 0..8 { let z = 8.0 + 1.0 + k.to_float() * 1.33; grooves.push(torus(thread_d / 2.0 + 0.2, 0.45).translate([0, 0, z])); grooves.push(torus(thread_d / 2.0 + 0.2, 0.45).translate([0, 0, -1.0 - k.to_float() * 1.33])); }
part - compound(grooves) - cylinder([0, 0, -30], "Z", bore / 2.0, 60)
