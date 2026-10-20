// 1/4 in magnetic bit holder: 6.35 mm hex shank 25 mm with a snap-ring groove, 12 mm barrel 35 mm with a 6.35 mm hex socket 12 mm deep
let len = 60.0; // [50.0, 150.0] Overall length (mm)
let rc = 6.35 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(hp);
let shank = hex.to_face().extrude(25.5).chamfer(0.5, "<Z") - torus(3.6, 0.8).translate([0, 0, 6.5]);
let barrel = cylinder([0, 0, 25.0], "Z", 6.0, len - 25.0).chamfer(0.6, ">Z");
shank + barrel - hex.to_face().extrude(12.5).translate([0, 0, len - 12.0])
