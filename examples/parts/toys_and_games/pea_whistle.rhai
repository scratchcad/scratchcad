// Pea whistle: 22 mm drum chamber 13 mm wide, 28 mm mouthpiece with a 3 x 10 mm windway, sound window and lanyard ring
let d = 22.0; // [16.0, 30.0] Chamber diameter (mm)
let w = 13.0; // [10.0, 18.0] Width (mm)
let r = d / 2.0;
let body = cylinder([0, -w / 2.0, 0], "Y", r, w) + box_from_corners([0, -w / 2.0, r - 7.0], [28.0, w / 2.0, r]);
body -= cylinder([0, -w / 2.0 + 1.5, 0], "Y", r - 1.5, w - 3.0);
body -= box_from_corners([-1.0, -5.0, r - 4.5], [29.0, 5.0, r - 1.5]);
body -= box_from_corners([-6.0, -w / 2.0 + 1.5, r - 4.5], [-1.0, w / 2.0 - 1.5, r + 1.0]);
body + torus(3.0, 1.0).rotate_x(90.0).translate([-r - 1.5, 0, -r * 0.4])
