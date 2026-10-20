// Hexagonal pen cup: 80 mm across flats, 100 mm tall, 3 mm walls, twisted 30 degrees from base to top
let across_flats = 80.0; // [50.0, 120.0] Across flats (mm)
let height = 100.0; // [60.0, 160.0] Height (mm)
let twist = 30.0; // [0.0, 60.0] Twist (degrees)
let wall = 3.0; // [1.5, 6.0] Wall thickness (mm)
let rc = across_flats / sqrt(3.0);
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(pts);
let sections = [];
for k in 0..=4 { let f = k.to_float() / 4.0; sections.push(hex.rotate_z(twist * f).translate([0, 0, height * f])); }
loft(sections, true).shell(-wall, ">Z")
