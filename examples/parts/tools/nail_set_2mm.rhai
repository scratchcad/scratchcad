// Nail set, 2 mm: 10 mm square-grip knurled body 110 mm, taper to a 2 mm cupped tip, chamfered striking end
let tip = 2.0; // [0.8, 4.0] Tip diameter (mm)
let body = box_centered(10.0, 10.0, 70.0).translate([0, 0, 75.0]).chamfer(1.5, "|Z") + cylinder([0, 0, 25.0], "Z", 5.0, 15.0) + cylinder([0, 0, 110.0], "Z", 5.0, 5.0).chamfer(1.0, ">Z");
let taper = cone(tip / 2.0, 5.0, 25.0);
let ns = body + taper - sphere([0, 0, -tip * 0.25], tip * 0.45);
for k in 0..8 { ns -= box_centered(12.0, 12.0, 0.8).translate([0, 0, 50.0 + k.to_float() * 6.0]) - box_centered(9.0, 9.0, 2.0).translate([0, 0, 50.0 + k.to_float() * 6.0]); }
ns
