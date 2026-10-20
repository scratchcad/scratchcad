// DIN 562 M4 thin square nut: 7 mm square, 2.2 mm thick
let width = 7.0; // [4.0, 17.0] Width across flats (mm)
let thickness = 2.2; // [1.2, 5.0] Thickness (mm)
let bore = 3.3; // [2.0, 10.0] Bore (mm)
let nut = box_centered(width, width, thickness).translate([0, 0, thickness / 2.0]).chamfer(0.3, "|Z");
nut - cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0)
