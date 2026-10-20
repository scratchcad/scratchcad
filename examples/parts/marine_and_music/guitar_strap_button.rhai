// Guitar strap button: 14 mm head, 9.5 mm waist, 11 mm base 2 mm thick, 20 mm overall, 3.5 mm screw hole with counterbore
let head = 14.0; // [11.0, 18.0] Head diameter (mm)
let b = sketch("XZ").move_to(0, 0).line_to(5.5, 0).line_to(5.5, 2.0).line_to(4.75, 3.0).line_to(4.75, 14.0).arc_to(head / 2.0 + 0.5, 17.0, head / 2.0 - 1.0, 20.0).line_to(0, 20.0).close().to_face().revolve("Z", 360);
b - cylinder([0, 0, -1], "Z", 1.75, 22.0) - cylinder([0, 0, 15.0], "Z", 3.2, 6.0)
