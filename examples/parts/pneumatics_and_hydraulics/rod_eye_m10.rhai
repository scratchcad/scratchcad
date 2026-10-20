// Pneumatic cylinder rod eye (spherical-less), M10 x 1.25: 28 mm eye, 10 mm bore, 14 mm thick, 43 mm to centre
let eye_d = 28.0; // [20.0, 40.0] Eye diameter (mm)
let bore = 10.0; // [6.0, 16.0] Bore (mm)
let t = 14.0; // [10.0, 20.0] Thickness (mm)
let length = 43.0; // [30.0, 60.0] Length to eye centre (mm)
let thread_d = 10.0; // [8.0, 16.0] Thread (mm)
let eye = cylinder([0, -t / 2.0, length], "Y", eye_d / 2.0, t);
let neck = cylinder(thread_d / 2.0 + 4.0, length);
let flats = box_from_corners([-20, -t / 2.0, 6.0], [20, t / 2.0, length]);
let n = neck & (flats + box_from_corners([-20, -20, -1], [20, 20, 6.0]));
eye + n - cylinder([0, -t, length], "Y", bore / 2.0, 2.0 * t) - cylinder([0, 0, -1], "Z", thread_d / 2.0 - 0.7, 20.0)
