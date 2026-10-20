// Cast iron grate lifter: 250 mm 8 mm rod, 25 mm hook, wood handle socket 22 mm x 100 mm
let length = 250.0; // [180.0, 350.0] Rod length (mm)
let rod = 8.0; // [6.0, 12.0] Rod diameter (mm)
let hook = 25.0; // [15.0, 40.0] Hook depth (mm)
let r = rod / 2.0;
let shaft = cylinder([0, 0, 0], "X", r, length);
let elbow = sphere([length, 0, 0], r + 0.4);
let down = cylinder([length, 0, -hook], "Z", r, hook);
let tip = sphere([length, 0, -hook], r + 0.4) + cylinder([length - 12.0, 0, -hook], "X", r, 12.0);
let handle = cylinder([-100.0, 0, 0], "X", 11.0, 100.01);
shaft + elbow + down + tip + handle
