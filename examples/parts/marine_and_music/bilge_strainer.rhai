// Bilge pump intake strainer: 60 mm dome 35 mm tall with 48 inlet slots, 38 mm base flange with two screw ears, 19 mm hose spigot
let d = 60.0; // [40.0, 100.0] Strainer diameter (mm)
let r = d / 2.0;
let dome = sketch("XZ").move_to(0, 0).line_to(r, 0).line_to(r, 15.0).arc_to(r * 0.7, 30.0, 0, 35.0).line_to(0, 33.0).arc_to(r * 0.68, 28.0, r - 2.0, 15.0).line_to(r - 2.0, 2.0).line_to(0, 2.0).close().to_face().revolve("Z", 360);
let slots = [];
for k in 0..24 { for z in [6.0, 11.0] { slots.push(box_centered(6.0, 2.0, 3.5).translate([r, 0, z]).rotate("Z", k.to_float() * 15.0 + z)); } }
let base = box_centered(d + 30.0, 20.0, 2.0).translate([0, 0, 1.0]).fillet(8.0, "|Z") - cylinder([d / 2.0 + 8.0, 0, -1], "Z", 2.2, 4.0) - cylinder([-d / 2.0 - 8.0, 0, -1], "Z", 2.2, 4.0);
let spigot = cylinder([0, 0, 30.0], "Z", 9.5, 30.0) - cylinder([0, 0, 25.0], "Z", 7.5, 40.0);
fuse_all([dome - fuse_all(slots), base, spigot]) - cylinder([0, 0, 25.0], "Z", 7.5, 15.0)
