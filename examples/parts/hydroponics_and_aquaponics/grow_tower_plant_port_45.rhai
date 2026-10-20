// Vertical grow tower plant port: a 50 mm round cup 60 mm long angled up at 45 degrees, 2 mm wall, on a curved saddle plate 3 mm thick that fits a 100 mm tower pipe, with the pipe bore cut through so water runs past the roots
let pipe_d = 100.0; // [75.0, 160.0] Tower pipe diameter (mm)
let cup_d = 50.0; // [35.0, 65.0] Cup outside diameter (mm)
let cup_len = 60.0; // [40.0, 90.0] Cup length (mm)
let angle = 45.0; // [30.0, 60.0] Cup angle above horizontal (degrees)
const wall = 2.0;
const saddle_t = 3.0;
let rp = pipe_d / 2.0;
let rc = cup_d / 2.0;
let sw = cup_d + 16.0;
let sh = cup_d / sin(angle * PI() / 180.0) + 16.0;
let saddle = cylinder([0, 0, -sh / 2.0], "Z", rp + saddle_t, sh) - cylinder([0, 0, -sh], "Z", rp, 2.0 * sh);
let saddle = saddle & box_from_corners([0, -sw / 2.0, -sh], [rp + 10.0, sw / 2.0, sh]);
let tilt = 90.0 - angle;
let back = cup_d;
let cup = cylinder([0, 0, -back], "Z", rc, cup_len + back).rotate_y(tilt).translate([rp - 6.0, 0, 0]);
let hole = cylinder([0, 0, -back - 1.0], "Z", rc - wall, cup_len + back + 2.0).rotate_y(tilt).translate([rp - 6.0, 0, 0]);
let body = (saddle + cup) - cylinder([0, 0, -2.0 * sh], "Z", rp, 4.0 * sh);
body - hole
