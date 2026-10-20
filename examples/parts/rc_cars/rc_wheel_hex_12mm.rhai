// RC car 12 mm wheel hex adapter: 12 mm across flats hex 6 mm thick with a 2 mm cross-pin slot for a 5 mm axle, 5.1 mm bore and a 0.5 mm chamfer each side
let af = 12.0; // [10.0, 17.0] Hex across flats (mm)
let axle = 5.0; // [3.0, 6.0] Axle diameter (mm)
let t = 6.0; // [4.0, 10.0] Hex thickness (mm)
let r = af / 2.0 / cos(PI() / 6.0);
let pts = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; pts.push([r * cos(a), r * sin(a), 0]); }
let h = face(polygon(pts)).extrude([0, 0, t]);
let h = h.chamfer(0.5, h.edges(">Z or <Z"));
h - cylinder([0, 0, -1.0], "Z", axle / 2.0 + 0.05, t + 2.0) - box_centered(af + 2.0, 2.1, 2.5).translate([0, 0, t - 1.25 + 0.01])
