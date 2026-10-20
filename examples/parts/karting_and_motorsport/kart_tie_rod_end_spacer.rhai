// Kart tie rod end spacer for an M8 rod end: 8.2 mm bore, 18 mm base 3 mm thick tapering over 7 mm to a 12 mm nose that sits on the ball, 10 mm overall, 0.5 mm edge breaks
let bolt_d = 8.0; // [6.0, 10.0] Bolt diameter (mm)
let base_d = 18.0; // [15.0, 24.0] Base diameter (mm)
let nose_d = 12.0; // [10.0, 15.0] Nose diameter (mm)
let length = 10.0; // [6.0, 20.0] Spacer length (mm)
const base_t = 3.0;
let ri = bolt_d / 2.0 + 0.1;
let rn = max(nose_d / 2.0, ri + 1.5);
let rb = base_d / 2.0;
face(polygon([[ri, 0, 0], [rb - 0.5, 0, 0], [rb, 0, 0.5], [rb, 0, base_t], [rn, 0, length - 0.5], [rn - 0.5, 0, length], [ri, 0, length]])).revolve("Z", 360.0)
