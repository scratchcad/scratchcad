// 3/4 in bronze through-hull: 50 mm mushroom head, 27 mm threaded shank 75 mm long, 20 mm bore, 41 mm backing nut
let shank = 75.0; // [40.0, 120.0] Shank length (mm)
let head = sketch("XZ").move_to(10.0, 0).line_to(25.0, 0).arc_to(22.0, 4.0, 13.5, 6.0).line_to(10.0, 6.0).close().to_face().revolve("Z", 360);
let body = head + cylinder([0, 0, -shank], "Z", 13.5, shank + 0.1) - cylinder([0, 0, -shank - 1.0], "Z", 10.0, shank + 10.0);
for k in 0..20 { body -= torus(13.6, 0.5).translate([0, 0, -shank + 4.0 + k.to_float() * 1.814 * 2.0]); }
let rc = 41.0 / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let nut = polygon(hp).to_face().extrude(12.0).translate([0, 0, -30.0]).chamfer(1.0, ">Z or <Z") - cylinder([0, 0, -31.0], "Z", 13.6, 14.0);
compound([body, nut])
