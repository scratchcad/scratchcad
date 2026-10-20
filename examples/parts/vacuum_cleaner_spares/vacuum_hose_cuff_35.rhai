// Vacuum hose cuff for 35 mm wands: 32 mm hose thread end 30 mm, 35.5 mm socket 40 mm, 2.5 mm wall
let wand = 35.0; // [30.0, 40.0] Wand OD (mm)
let hose = 32.0; // [28.0, 38.0] Hose ID (mm)
let wall = 2.5; // [2.0, 3.5] Wall (mm)
let socket = cylinder(wand / 2.0 + 0.3 + wall, 40.0) - cylinder([0, 0, -1], "Z", wand / 2.0 + 0.3, 41.0);
let tail = cylinder([0, 0, 39.99], "Z", hose / 2.0 + 0.5, 30.0) - cylinder([0, 0, 39.0], "Z", hose / 2.0 + 0.5 - wall, 32.0);
let ribs = [];
for k in 0..5 { ribs.push(cylinder([0, 0, 43.0 + k.to_float() * 5.0], "Z", hose / 2.0 + 2.0, 1.5) - cylinder([0, 0, 42.0 + k.to_float() * 5.0], "Z", hose / 2.0, 4.0)); }
let stop = cylinder([0, 0, 38.0], "Z", wand / 2.0 + 0.31, 2.01) - cylinder([0, 0, 37.0], "Z", hose / 2.0 + 0.5 - wall, 4.0);
socket + tail + compound(ribs) + stop
