// UK socket safety cover: 3 pins (earth 8 x 4 mm 22 mm, two 6.4 x 3.9 mm 15 mm at 22.2 mm), 40 x 30 mm face 4 mm
let face_w = 40.0; // [35.0, 50.0] Face width (mm)
let face_h = 30.0; // [25.0, 40.0] Face height (mm)
let t = 4.0; // [3.0, 6.0] Face thickness (mm)
let face = box_centered(face_w, face_h, t).translate([0, 0, t / 2.0]);
let f = face.fillet(5.0, face.edges("|Z"));
let earth = box_centered(4.0, 8.0, 22.0).translate([0, 9.0, -10.99]);
let pins = box_centered(3.9, 6.4, 15.0).translate([-11.1, -9.0, -7.49]) + box_centered(3.9, 6.4, 15.0).translate([11.1, -9.0, -7.49]);
let grip = box_centered(20.0, 6.0, 8.0).translate([0, 0, t + 3.99]);
f + earth + pins + grip.fillet(2.5, grip.edges("|Y and >Z"))
