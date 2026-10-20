// Hexagonal tealight holder: 70 mm across flats, 35 mm tall, 39.5 mm tealight pocket 17 mm deep, 6 window slots
let flats = 70.0; // [50.0, 100.0] Across flats (mm)
let height = 35.0; // [20.0, 60.0] Height (mm)
let pocket = 39.5; // [38.0, 42.0] Tealight cup diameter (mm)
let rc = flats / 3.0.sqrt();
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let body = polygon(pts).to_face().extrude([0, 0, height]);
let slots = [];
for k in 0..6 { slots.push(box_centered(flats, 6.0, height - 14.0).translate([0, 0, height / 2.0 + 2.0]).rotate_z(k.to_float() * 60.0)); }
body - cylinder([0, 0, height - 17.0], "Z", pocket / 2.0, 18.0) - (fuse_all(slots) - cylinder([0, 0, -1], "Z", flats / 2.0 - 3.0, height + 2.0))
