// Tealight candle holder: 60 mm hexagonal block 30 mm tall with a 39 mm x 16 mm tealight pocket and chamfered edges
let size = 60.0; // [45.0, 100.0] Across flats (mm)
let height = 30.0; // [20.0, 60.0] Height (mm)
let pocket_d = 39.5; // [38.0, 60.0] Pocket diameter (mm)
let pocket_h = 16.0; // [10.0, 25.0] Pocket depth (mm)
let rc = size / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let block = polygon(pts).to_face().extrude(height).chamfer(2.0, "not |Z");
block - cylinder([0, 0, height - pocket_h], "Z", pocket_d / 2.0, pocket_h + 1.0)
