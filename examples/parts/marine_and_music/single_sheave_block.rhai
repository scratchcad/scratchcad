// Single sailing block: 40 mm sheave for 10 mm line on a 6 mm axle between 2.5 mm cheek plates, top shackle eye
let sheave_d = 40.0; // [25.0, 80.0] Sheave diameter (mm)
let line = 10.0; // [6.0, 14.0] Line diameter (mm)
let R = sheave_d / 2.0;
let sheave = cylinder([0, -line / 2.0 - 1.0, 0], "Y", R, line + 2.0) - torus(R, line / 2.0 + 0.3).rotate_x(90.0) - cylinder([0, -line, 0], "Y", 3.2, 2.0 * line);
let cheek = sketch("XZ").move_to(-R - 3.0, 0).arc_to(0, -R - 3.0, R + 3.0, 0).line_to(8.0, R + 14.0).line_to(-8.0, R + 14.0).close().to_face().extrude(2.5);
let cheeks = fuse_all([cheek.translate([0, line / 2.0 + 1.5 + 2.5, 0]), cheek.translate([0, -line / 2.0 - 1.5, 0]), box_from_corners([-8.0, -line / 2.0 - 1.5, R + 6.0], [8.0, line / 2.0 + 4.0, R + 14.0]), cylinder([0, -line / 2.0 - 2.0, 0], "Y", 3.0, line + 6.5)]);
cheeks = cheeks - cylinder([0, -20, R + 10.0], "Y", 3.0, 40.0);
compound([cheeks, sheave])
