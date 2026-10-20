// M12 x 100 wedge anchor: 12 mm stud with a rolled-in cone, 3-segment expansion clip 1 mm thick, washer and hex nut
let len = 100.0; // [70.0, 200.0] Anchor length (mm)
let stud = cylinder([0, 0, 12.0], "Z", 6.0, len - 12.0) + cone(6.8, 5.0, 12.0) - torus(5.4, 0.6).translate([0, 0, 13.0]);
let clip = cylinder([0, 0, 12.0], "Z", 6.8, 14.0) - cylinder([0, 0, 11.0], "Z", 5.8, 16.0);
for k in 0..3 { clip -= box_centered(1.5, 10.0, 16.0).translate([0, 6.0, 19.0]).rotate_z(k.to_float() * 120.0); }
let rc = 19.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let nut = polygon(hp).to_face().extrude(10.0).translate([0, 0, len - 12.0]).chamfer(1.0, ">Z or <Z") - cylinder([0, 0, len - 13.0], "Z", 6.0, 12.0);
let washer = cylinder([0, 0, len - 14.5], "Z", 12.0, 2.5) - cylinder([0, 0, len - 15.0], "Z", 6.5, 3.5);
compound([stud, clip, washer, nut])
