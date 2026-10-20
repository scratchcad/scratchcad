// 1/10 RC buggy wheel rim: 52 mm x 26 mm with bead lips, five spokes, hub with a 12 mm hex drive recess and 5 mm axle bore
let d = 52.0; // [40.0, 70.0] Rim diameter (mm)
let w = 26.0; // [18.0, 40.0] Rim width (mm)
let r = d / 2.0;
let rim = cylinder(r, w) - cylinder([0, 0, -1], "Z", r - 2.5, w + 2.0);
let lip = cylinder(r + 1.0, 2.0) - cylinder([0, 0, -1], "Z", r - 2.0, 4.0);
let parts = [rim, lip, lip.translate([0, 0, w - 2.0]), cylinder([0, 0, w - 16.0], "Z", 8.0, 16.0)];
for k in 0..5 { parts.push(box_from_corners([6.0, -2.5, w - 6.0], [r - 1.0, 2.5, w - 2.0]).rotate("Z", k.to_float() * 72.0)); }
let wheel = fuse_all(parts);
let rc = 12.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
wheel - polygon(hp).to_face().extrude(6.0).translate([0, 0, w - 16.0 - 0.01]) - cylinder([0, 0, -1], "Z", 2.5, w + 2.0)
