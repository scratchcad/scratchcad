// Snowboard stomp pad: 80 x 60 mm diamond-ish octagon 4 mm base with a 4 x 4 grid of 6 mm studs 3 mm tall and a 1 mm adhesive recess underneath
let length = 80.0; // [60.0, 120.0] Pad length (mm)
let width = 60.0; // [45.0, 90.0] Pad width (mm)
const t = 4.0;
let pts = [];
for i in 0..8 { let a = (22.5 + 45.0 * i.to_float()) * PI() / 180.0; pts.push([length / 2.0 * cos(a) / cos(PI() / 8.0), width / 2.0 * sin(a) / cos(PI() / 8.0), 0]); }
let p = face(polygon(pts)).extrude([0, 0, t]);
let studs = [];
for i in 0..4 { for j in 0..4 { studs.push(cylinder([(i.to_float() - 1.5) * length * 0.18, (j.to_float() - 1.5) * width * 0.18, t - 0.01], "Z", 3.0, 3.0)); } }
p + fuse_all(studs) - face(polygon(pts)).extrude([0, 0, 1.0]).scale([0, 0, 0], 0.85).translate([0, 0, -0.01])
