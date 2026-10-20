// Tennis racket butt cap: octagonal 32 x 27 mm cap 10 mm tall, hollowed from below with about 3 mm side walls and a 4 mm top, 1 mm top bevel and a 12 mm logo recess 0.5 mm deep
let across = 32.0; // [28.0, 36.0] Width across the flats (mm)
let depth = 27.0; // [24.0, 32.0] Depth across the flats (mm)
const h = 10.0;
let pts = [];
for i in 0..8 { let a = (22.5 + 45.0 * i.to_float()) * PI() / 180.0; pts.push([across / 2.0 / cos(PI() / 8.0) * cos(a), depth / 2.0 / cos(PI() / 8.0) * sin(a), 0]); }
let outer = face(polygon(pts)).extrude([0, 0, h]);
let outer = outer.chamfer(1.0, outer.edges(">Z"));
let inner = outer.scale([0, 0, 0], 0.8).translate([0, 0, -2.0]);
outer - inner - cylinder([0, 0, h - 0.5], "Z", 6.0, 1.0)
