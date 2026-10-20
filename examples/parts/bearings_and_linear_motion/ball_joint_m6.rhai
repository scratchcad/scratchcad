// DIN 71802 angle ball joint M6: 13 mm ball on an M6 stud, socket housing with a side-tapped M6 boss
let ball_d = 13.0; // [8.0, 22.0] Ball diameter (mm)
let stud_d = 6.0; // [4.0, 12.0] Stud diameter (mm)
let stud_l = 12.0; // [8.0, 30.0] Stud length (mm)
let socket_d = 20.0; // [14.0, 32.0] Socket outside diameter (mm)
let ball = sphere(ball_d / 2.0) + cylinder([0, 0, -stud_l - ball_d * 0.3], "Z", stud_d / 2.0, stud_l) + cylinder([0, 0, -ball_d * 0.6], "Z", stud_d * 0.75, ball_d * 0.3);
let socket = (sphere(socket_d / 2.0) & box_centered(socket_d, socket_d, socket_d).translate([0, 0, socket_d * 0.2])) - sphere(ball_d / 2.0 + 0.05);
socket = socket + cylinder([0, socket_d * 0.3, 0], "Y", stud_d * 0.9, socket_d * 0.6) - cylinder([0, socket_d * 0.3, 0], "Y", stud_d * 0.42, socket_d);
[ball, socket]
