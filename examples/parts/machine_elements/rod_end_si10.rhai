// Rod end SI 10 E (ISO 12240-4, female M10 thread): 10 mm ball bore, 9 mm ball width, 29 mm eye in a 7.5 mm wide housing, 43 mm from eye centre to shank end, 13 mm wrench flats
let bore = 10.0; // [5.0, 20.0] Ball bore (mm)
let ball_width = 9.0; // [5.0, 18.0] Ball width (mm)
let eye_diameter = 29.0; // [16.0, 50.0] Eye outer diameter (mm)
let housing_width = 7.5; // [4.0, 15.0] Housing width (mm)
let centre_to_end = 43.0; // [25.0, 80.0] Eye centre to shank end (mm)
let thread_diameter = 10.0; // [5.0, 20.0] Thread size (mm)
let re = eye_diameter / 2.0;
let rb = max(bore / 2.0 + 2.5, re * 0.55);
let bw = min(ball_width, rb * 1.6);
let hw = min(housing_width, bw - 0.5);
// housing: eye ring with a spherical seat, and a shank along -Z
let neck_r = max(thread_diameter * 0.75, re * 0.5);
let eye = cylinder([0, -hw / 2.0, 0], "Y", re, hw);
let shank = cylinder([0, 0, -centre_to_end], "Z", neck_r, centre_to_end - re * 0.6);
let flats = box_centered(neck_r * 1.73, neck_r * 2.2, 10.0).translate([0, 0, -re - 4.0]);
let housing = fuse_all([eye, shank]);
housing = housing - (box_centered(neck_r * 3.0, neck_r * 3.0, 10.0).translate([0, 0, -re - 4.0]) - flats);
housing = housing - sphere(rb + 0.05);
housing = housing - cylinder([0, 0, -centre_to_end - 1.0], "Z", thread_diameter * 0.425, thread_diameter * 2.0 + 1.0);
housing = housing.chamfer(0.5, "%CIRCLE and <Z");
// ball: truncated sphere with the bore
let ball = sphere(rb) & box_centered(2.0 * rb + 2.0, bw, 2.0 * rb + 2.0);
ball = ball - cylinder([0, -bw, 0], "Y", bore / 2.0, 2.0 * bw);
compound([housing, ball])
