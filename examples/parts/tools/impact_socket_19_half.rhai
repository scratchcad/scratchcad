// 19 mm 6-point impact socket, 1/2 in drive: 30 mm OD 38 mm long, 12.7 mm square drive with a 4 mm cross pin hole, 6 mm O-ring groove
let size = 19.0; // [10.0, 32.0] Size across flats (mm)
let od = 30.0; // [20.0, 50.0] Outer diameter (mm)
let len = 38.0; // [30.0, 80.0] Length (mm)
let rc = size / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let s = cylinder(od / 2.0, len).chamfer(1.0, "%CIRCLE") - polygon(hp).to_face().extrude(18.0).translate([0, 0, len - 17.0]) - box_centered(12.7, 12.7, 30.0);
s - torus(od / 2.0, 1.2).translate([0, 0, 7.0]) - cylinder([-od, 0, 7.0], "X", 2.0, 2.0 * od)
