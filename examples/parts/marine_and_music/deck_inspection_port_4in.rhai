// 4 in deck inspection port: 152 mm flange ring 3 mm thick on a 102 mm collar 20 mm deep, six screw holes, screw-in lid with a grip bar
let open = 102.0; // [76.0, 152.0] Opening (mm)
let r = open / 2.0;
let ring = cylinder([0, 0, -20.0], "Z", r + 3.0, 20.0) + cylinder(r + 25.0, 3.0).chamfer(1.0, ">Z") - cylinder([0, 0, -21.0], "Z", r, 25.0);
for k in 0..6 { ring -= cylinder([r + 15.0, 0, -1], "Z", 2.25, 5.0).rotate("Z", k.to_float() * 60.0); }
let lid = cylinder([0, 0, -12.0], "Z", r - 0.3, 12.0) - cylinder([0, 0, -13.0], "Z", r - 2.3, 11.0) + cylinder([0, 0, 0], "Z", r + 4.0, 4.0).chamfer(1.5, ">Z") + box_centered(r * 1.3, 10.0, 8.0).translate([0, 0, 7.0]).fillet(3.0, ">Z");
compound([ring, lid.translate([0, 0, 3.5])])
