// Desk leg leveling foot: 40 mm swivel pad 10 mm tall, M8 x 30 mm stud, 13 mm hex 6 mm
let pad = 40.0; // [25.0, 60.0] Pad diameter (mm)
let stud_l = 30.0; // [15.0, 50.0] Stud length (mm)
let stud_d = 8.0; // [6.0, 12.0] Stud diameter (mm)
let base = cylinder(pad / 2.0, 10.0);
let b = base.chamfer(2.0, base.edges(">Z"));
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([13.0 / 3.0.sqrt() * a.cos(), 13.0 / 3.0.sqrt() * a.sin()]); }
let hex = polygon(pts).to_face().extrude([0, 0, 6.0]).translate([0, 0, 9.99]);
b + hex + cylinder([0, 0, 15.98], "Z", stud_d / 2.0, stud_l)
