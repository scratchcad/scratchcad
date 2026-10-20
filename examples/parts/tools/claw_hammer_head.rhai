// 16 oz claw hammer head: 28 mm round face with chamfer, 22 x 34 mm body, 25 x 13 mm oval eye, curved split claw 95 mm from the eye
let face_d = 28.0; // [22.0, 35.0] Face diameter (mm)
let w = 22.0; // [18.0, 28.0] Body width (mm)
let face = cylinder([-55.0, 0, 0], "X", face_d / 2.0, 31.0).chamfer(1.5, "<X");
let body = box_from_corners([-25.0, -w / 2.0, -17.0], [15.0, w / 2.0, 17.0]);
let claw = polygon([[14, 0, -17], [14, 0, 17], [60, 0, 5], [95, 0, -25], [90, 0, -29], [50, 0, -12]]).to_face().extrude([0, w, 0]).translate([0, -w / 2.0, 0]);
let head = fuse_all([face, body, claw]);
let eye = box_centered(12.0, 13.0, 60.0).translate([-5.0, 0, 0]) + cylinder([-11.0, 0, -30.0], "Z", 6.5, 60.0) + cylinder([1.0, 0, -30.0], "Z", 6.5, 60.0);
head - eye - polygon([[40, -0.5], [100, -5], [100, 5], [40, 0.5]]).to_face().extrude(80.0).translate([0, 0, -40.0])
