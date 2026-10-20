// Hospital bed side-rail end bumper: push-on rubber cap for a 25.4 mm rail tube, 40 mm diameter, 45 mm long with a 30 mm deep socket and a 5 mm chamfered nose
let tube_d = 25.4; // [19.0, 32.0] Rail tube diameter (mm)
let dia = 40.0; // [36.0, 55.0] Bumper diameter (mm)
let length = 45.0; // [38.0, 70.0] Bumper length (mm)
const socket = 30.0;
let r = dia / 2.0;
let b = face(polygon([[0, 0, 0], [r - 5.0, 0, 0], [r, 0, 5.0], [r, 0, length - 1.0], [r - 1.0, 0, length], [0, 0, length]])).revolve("Z", 360);
b - cylinder([0, 0, length - socket], "Z", tube_d / 2.0 - 0.2, socket + 1.0)
