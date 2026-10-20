// 5 mm hex key: L shape 85 x 30 mm, swept hexagon with a mitred bend and chamfered ends
let af = 5.0; // [1.5, 12.0] Across flats (mm)
let long = 85.0; // [40.0, 200.0] Long arm (mm)
let short = 30.0; // [15.0, 60.0] Short arm (mm)
let rc = af / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin(), 0]); }
polygon(hp).to_face().sweep(polyline([[0, 0, 0], [0, 0, long], [short, 0, long]]))
