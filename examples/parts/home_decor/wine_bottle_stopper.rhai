// Wine bottle stopper: 3 ribbed seals 19 to 21 mm, 30 mm long, 32 mm faceted top 25 mm tall
let neck = 19.0; // [17.0, 22.0] Bottle bore (mm)
let plug_l = 30.0; // [20.0, 40.0] Plug length (mm)
let top_d = 32.0; // [25.0, 45.0] Top diameter (mm)
let core = cylinder([0, 0, -plug_l], "Z", neck / 2.0 - 1.0, plug_l + 0.01);
let ribs = [];
for k in 0..3 { ribs.push(cone(neck / 2.0 + 0.5 - k.to_float() * 0.6, neck / 2.0 - 1.0, 5.0).rotate_x(180.0).translate([0, 0, -6.0 - k.to_float() * 8.0 + 5.0])); }
let pts = [];
for i in 0..8 { let a = (i.to_float() * 45.0 + 22.5) * PI() / 180.0; pts.push([top_d / 2.0 * a.cos(), top_d / 2.0 * a.sin()]); }
let top = polygon(pts).to_face().extrude([0, 0, 25.0]) & sphere([0, 0, 2.0], 28.0);
core + fuse_all(ribs) + top
