// 100 ml graduated cylinder: 29 mm tube 250 mm tall with 1.2 mm wall, hexagonal 70 mm base, beaded rim with spout, raised 10 ml rings
let h = 250.0; // [150.0, 400.0] Height (mm)
let r = 14.5; // [8.0, 30.0] Tube radius (mm)
let rc = 70.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let base = polygon(hp).to_face().extrude(8.0).chamfer(1.5, ">Z") + cylinder([0, 0, 7.9], "Z", r + 4.0, 6.0);
let tube = cylinder([0, 0, 7.9], "Z", r, h - 8.0) - cylinder([0, 0, 12.0], "Z", r - 1.2, h);
let rim = torus(r, 1.2).translate([0, 0, h - 0.5]) + polygon([[r - 1.0, 0, h - 6.0], [r + 5.0, 0, h], [r - 1.0, 0, h]]).to_face().extrude([0, 6.0, 0]).translate([0, -3.0, 0]) - cylinder([0, 0, h - 8.0], "Z", r - 1.2, 10.0);
let rings = [];
for k in 1..10 { rings.push(cylinder([0, 0, 30.0 + k.to_float() * (h - 50.0) / 10.0], "Z", r + 0.3, 0.6) - cylinder([0, 0, 0], "Z", r - 0.5, h)); }
fuse_all([base, tube, rim] + rings)
