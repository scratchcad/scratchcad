// 10 ml Luer slip syringe: 16 mm barrel 80 mm long with 0.75 mm wall, 36 mm finger flange, 6% Luer tip; plunger with cross-ribbed rod and seal
let len = 80.0; // [50.0, 110.0] Barrel length (mm)
let barrel = cylinder(8.0, len) - cylinder([0, 0, 1.5], "Z", 7.25, len);
let flange = box_centered(36.0, 16.0, 2.0).translate([0, 0, len - 1.0]).fillet(5.0, "|Z") - cylinder([0, 0, len - 3.0], "Z", 7.25, 5.0);
let tip = cone(2.15, 1.95, 9.0).translate([0, 0, -9.0]) + cone(3.0, 2.15, 2.0).translate([0, 0, -2.0]) - cylinder([0, 0, -10.0], "Z", 0.6, 12.0);
let rod = box_centered(12.0, 1.5, len) + box_centered(1.5, 12.0, len);
let plunger = fuse_all([rod.translate([0, 0, len / 2.0 + 12.0]), cylinder([0, 0, 8.0], "Z", 7.2, 6.0), cylinder([0, 0, len + 12.0], "Z", 10.0, 2.0)]);
compound([fuse_all([barrel, flange, tip]), plunger])
