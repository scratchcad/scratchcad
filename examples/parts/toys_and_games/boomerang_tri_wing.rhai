// Tri-wing indoor boomerang: three 120 mm wings 30 mm wide, 3 mm plate, chamfered leading edges, rounded tips
let reach = 120.0; // [80.0, 160.0] Wing length (mm)
let w = 30.0; // [20.0, 40.0] Wing width (mm)
let b = cylinder(w * 0.8, 3.0);
for k in 0..3 { b += (box_from_corners([0, -w / 2.0, 0], [reach, w / 2.0, 3.0]) + cylinder([reach, 0, 0], "Z", w / 2.0, 3.0)).rotate("Z", k.to_float() * 120.0); }
b.fillet(1.2, ">Z")
