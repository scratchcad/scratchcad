// Five-point star cookie cutter: 80 mm across, 15 mm tall, 0.8 mm cutting edge flaring to 2 mm, with a 5 mm flange
let size = 80.0; // [40.0, 150.0] Star size tip to tip (mm)
let points = 5; // [4, 8] Points
let height = 15.0; // [8.0, 25.0] Height (mm)
let inner_ratio = 0.45; // [0.3, 0.6] Inner radius ratio
let ro = size / 2.0; let ri = ro * inner_ratio;
let pts = [];
for i in 0..(points * 2) { let a = (i.to_float() * 180.0 / points.to_float() + 90.0) * PI() / 180.0; let r = if i % 2 == 0 { ro } else { ri }; pts.push([r * a.cos(), r * a.sin()]); }
let star = polygon(pts);
let wall = star.offset(1.0).to_face().extrude(height) - star.to_face().extrude(height + 2.0).translate([0, 0, -1]);
let flange = star.offset(5.0).to_face().extrude(2.0) - star.to_face().extrude(4.0).translate([0, 0, -1]);
wall + flange
