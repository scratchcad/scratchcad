// Quarter-turn cabinet lock insert with an 8 mm male square: 18 mm body 20 mm long with 16 mm anti-rotation flats, 22 mm x 2 mm front collar, 13 mm recess 10 mm deep around the square, 6 mm square cam stem 10 mm long with an M4 (3.3 mm) tapped hole
let square = 8.0; // [6.0, 9.0] Key square size (mm)
let body_length = 20.0; // [14.0, 30.0] Body length (mm)
let stem_length = 10.0; // [6.0, 16.0] Cam stem length (mm)
const body_d = 18.0;
const flats = 16.0;
const collar_d = 22.0;
const collar_t = 2.0;
let recess_r = min(square * 0.75 + 0.5, 7.0);
let recess_depth = body_length / 2.0;
let body = cylinder([0, 0, 0], "Z", body_d / 2.0, body_length) & box_centered(body_d + 2.0, flats, body_length * 3.0);
let collar = cylinder([0, 0, body_length - 0.5], "Z", collar_d / 2.0, collar_t + 0.5);
let top = body_length + collar_t;
let recess = cylinder([0, 0, top - recess_depth], "Z", recess_r, recess_depth + 1.0);
let key = box_centered(square, square, recess_depth).translate([0, 0, top - recess_depth / 2.0 - 0.01]);
let key = key.chamfer(0.5, key.edges(">Z"));
let stem = box_centered(6.0, 6.0, stem_length + 0.5).translate([0, 0, -stem_length / 2.0 + 0.25]);
let tap = cylinder([0, 0, -stem_length - 1.0], "Z", 1.65, 9.0);
(body + collar - recess) + key + stem - tap
