// Arcade joystick ball top: 35 mm ball with an M8 threaded bore (6.8 mm tap drill) 15 mm deep and a 12 mm flat collar at the bottom
let ball = 35.0; // [30.0, 40.0] Ball diameter (mm)
let bore_d = 6.8; // [5.0, 8.5] Tapped bore (mm)
let r = ball / 2.0;
let b = sphere([0, 0, r - 2.0], r) - box_centered(3.0 * r, 3.0 * r, 4.0).translate([0, 0, -2.0]);
let collar = cylinder([0, 0, 0], "Z", 6.0, 3.0);
b + collar - cylinder([0, 0, -1.0], "Z", bore_d / 2.0, 16.0)
