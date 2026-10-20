// DIN 603 M6 x 40 carriage bolt: 16 mm mushroom head, 6 mm square neck 4 mm long
let diameter = 6.0; // [5.0, 16.0] Thread diameter (mm)
let length = 40.0; // [16.0, 150.0] Length under head (mm)
let head_d = 16.0; // [13.0, 40.0] Head diameter (mm)
let head_h = 3.6; // [3.0, 9.0] Head height (mm)
let neck_l = 4.0; // [3.0, 9.0] Square neck length (mm)
let head = sketch("XZ").move_to(0, 0).hline_to(head_d / 2.0).vline(0.4).arc_to(head_d * 0.32, head_h * 0.85, 0, head_h).close().to_face().revolve("Z", 360);
let neck = box_centered(diameter, diameter, neck_l + 0.1).translate([0, 0, -neck_l / 2.0 + 0.05]);
head + neck + cylinder([0, 0, -length], "Z", diameter / 2.0, length - neck_l + 0.1).chamfer(0.6, "<Z")
