// Speaker isolation spike: 20 mm body 25 mm tall tapering to a 1 mm point over 15 mm, M6 threaded stud 15 mm long and a 10 mm AF hex flat band for a spanner
let dia = 20.0; // [14.0, 30.0] Body diameter (mm)
let point_l = 15.0; // [8.0, 25.0] Point length (mm)
const body_h = 10.0;
let body = cylinder([0, 0, 0], "Z", dia / 2.0, body_h);
let tip = cone(dia / 2.0, 0.5, point_l).rotate_x(180.0).translate([0, 0, 0.01]);
let stud = cylinder([0, 0, body_h - 0.01], "Z", 3.0, 15.0);
let flats = box_from_corners([-dia, -dia, body_h - 5.0], [dia, -5.0, body_h + 1.0]) + box_from_corners([-dia, 5.0, body_h - 5.0], [dia, dia, body_h + 1.0]);
body - flats + tip + stud
