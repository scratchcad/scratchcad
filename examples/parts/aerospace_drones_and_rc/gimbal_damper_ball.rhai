// Gimbal vibration damper ball: 15 mm rubber ball with 6 mm necks and 11 mm retaining flanges at both ends, 3 mm bore
let ball = 15.0; // [10.0, 22.0] Ball diameter (mm)
let r = ball / 2.0;
let parts = [sphere([0, 0, r], r), cylinder([0, 0, -2.0], "Z", 3.0, 3.0), cylinder([0, 0, 2.0 * r - 1.0], "Z", 3.0, 3.0), cylinder([0, 0, -3.5], "Z", 5.5, 1.5), cylinder([0, 0, 2.0 * r + 2.0], "Z", 5.5, 1.5)];
fuse_all(parts) - cylinder([0, 0, -5], "Z", 1.5, 2.0 * r + 10.0)
