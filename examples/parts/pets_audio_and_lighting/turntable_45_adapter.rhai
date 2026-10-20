// 45 rpm record adapter: 38 mm centre insert 6 mm tall with a 7.3 mm spindle hole and three retaining ribs, flange 44 mm
let d = 38.0; // [36.0, 38.4] Insert diameter (mm)
let a = (cylinder(d / 2.0, 6.0).chamfer(0.5, ">Z") + cylinder(22.0, 1.2)) - cylinder([0, 0, -1], "Z", 3.65, 8.0);
for k in 0..3 { a += box_centered(1.2, 1.0, 4.0).translate([d / 2.0 + 0.3, 0, 3.0]).rotate_z(k.to_float() * 120.0); }
a
