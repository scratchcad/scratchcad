// Hexagonal dice tray: 180 mm across flats, 30 mm tall, 3 mm walls, 2 mm floor with a felt recess 1 mm underneath
let flats = 180.0; // [120.0, 250.0] Across flats (mm)
let height = 30.0; // [20.0, 45.0] Height (mm)
let wall = 3.0; // [2.0, 5.0] Wall (mm)
let rc = flats / 3.0.sqrt();
let ri = (flats / 2.0 - wall) * 2.0 / 3.0.sqrt();
let po = [];
let pi_ = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; po.push([rc * a.cos(), rc * a.sin()]); pi_.push([ri * a.cos(), ri * a.sin()]); }
let outer = polygon(po).to_face().extrude([0, 0, height]);
let inner = polygon(pi_).to_face().extrude([0, 0, height]).translate([0, 0, 2.0]);
outer - inner - polygon(pi_).to_face().extrude([0, 0, 1.0]).scale(0.95).translate([0, 0, -0.01])
