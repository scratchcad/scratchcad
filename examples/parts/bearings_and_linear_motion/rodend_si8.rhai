// SI8T/K female rod end: 8 mm ball bore, 24 mm eye, 12 mm wide, M8 female thread, 42 mm from eye centre to end
let ball_bore = 8.0; // [5.0, 15.2] Ball bore (mm)
let eye_d = 24.0; // [16.0, 50.0] Eye diameter (mm)
let width = 12.0; // [8.0, 25.0] Ball width (mm)
let eye_t = 9.0; // [6.0, 20.0] Housing thickness (mm)
let shank_l = 30.0; // [20.0, 60.0] Shank length (mm)
let shank_d = 12.5; // [9.0, 25.0] Shank diameter (mm)
let eye = cylinder([0, -eye_t / 2.0, 0], "Y", eye_d / 2.0, eye_t);
let shank = cylinder([0, 0, -eye_d / 2.0 - shank_l + 3.0], "Z", shank_d / 2.0, shank_l);
let housing = (eye + shank) - sphere(eye_d * 0.36);
let ball = (sphere(eye_d * 0.355) & box_centered(eye_d, width, eye_d)) - cylinder([0, -width, 0], "Y", ball_bore / 2.0, width * 2.0);
let tapped = cylinder([0, 0, -eye_d / 2.0 - shank_l + 2.0], "Z", 3.4, shank_l * 0.7);
[housing - tapped, ball]
