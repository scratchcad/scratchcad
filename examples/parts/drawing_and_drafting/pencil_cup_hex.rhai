// Hexagonal desk pencil cup: 80 mm across flats, 100 mm tall, 3 mm wall, 4 mm base
let flats = 80.0; // [60.0, 120.0] Across flats (mm)
let height = 100.0; // [70.0, 140.0] Height (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let base = 4.0; // [2.0, 6.0] Base thickness (mm)
let pts = [];
let pi = PI();
let rc = flats / 3.0.sqrt();
for i in 0..6 { let a = (i.to_float() * 60.0) * pi / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let outer = polygon(pts).to_face().extrude([0, 0, height]);
let ri = (flats / 2.0 - wall) * 2.0 / 3.0.sqrt();
let ipts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * pi / 180.0; ipts.push([ri * a.cos(), ri * a.sin()]); }
let inner = polygon(ipts).to_face().extrude([0, 0, height]).translate([0, 0, base]);
outer - inner
