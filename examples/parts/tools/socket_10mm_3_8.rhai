// 10 mm 6-point socket, 3/8 in drive: 17 mm OD 28 mm long, 10 mm hex 9 mm deep, 9.53 mm square drive 10 mm deep, knurl band
let size = 10.0; // [6.0, 22.0] Size across flats (mm)
let od = 17.0; // [12.0, 30.0] Outer diameter (mm)
let len = 28.0; // [24.0, 50.0] Length (mm)
let s = cylinder(od / 2.0, len).chamfer(0.8, "%CIRCLE");
let rc = size / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
s -= polygon(hp).to_face().extrude(10.0).translate([0, 0, len - 9.0]);
s -= box_centered(9.53, 9.53, 20.0);
for k in 0..3 { s -= torus(od / 2.0 + 0.3, 0.6).translate([0, 0, 4.0 + k.to_float() * 2.0]); }
s
