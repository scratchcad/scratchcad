// Lamp cord strain relief bushing: 12 mm snap-in bushing for a 3 mm panel hole of 10 mm, 14 mm flange, 6 mm cord bore with a 1 mm grip ridge and a split skirt
let panel_hole = 10.0; // [8.0, 14.0] Panel hole diameter (mm)
let cord = 6.0; // [4.0, 8.0] Cord diameter (mm)
let b = cylinder([0, 0, 0], "Z", panel_hole / 2.0 + 2.0, 2.0) + cylinder([0, 0, -6.0], "Z", panel_hole / 2.0 - 0.1, 6.01) + cone(panel_hole / 2.0 + 0.6, panel_hole / 2.0 - 0.1, 2.0).translate([0, 0, -6.0]);
let bore = cylinder([0, 0, -7.0], "Z", cord / 2.0, 10.0);
let ridge = cylinder([0, 0, -2.0], "Z", cord / 2.0 + 0.01, 1.0) - cylinder([0, 0, -3.0], "Z", cord / 2.0 - 0.5, 3.0);
let split = box_centered(1.0, panel_hole + 4.0, 5.0).translate([0, 0, -4.5]);
b - bore + ridge - split
