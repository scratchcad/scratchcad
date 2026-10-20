// Shelf pin drilling jig, 32 mm system: 400 x 50 x 10 mm strip, 12 holes 5 mm at 32 mm pitch, 37 mm from the cabinet front, 8 mm fence 22 mm deep, end index hole
let holes = 12; // [4, 20] Number of holes
let pitch = 32.0; // [25.0, 50.0] Hole pitch (mm)
let setback = 37.0; // [20.0, 45.0] Hole distance from the cabinet edge (mm)
let hole_d = 5.0; // [3.0, 8.0] Hole diameter (mm)
let t = 10.0; // [6.0, 15.0] Strip thickness (mm)
let length = (holes + 1).to_float() * pitch;
let w = setback + 13.0;
let strip = box_from_corners([0, 0, 0], [length, w, t]);
let fence = box_from_corners([0, -8.0, -12.0], [length, 0.01, t]);
let cuts = [];
for i in 0..(holes + 1) { cuts.push(cylinder([pitch / 2.0 + i.to_float() * pitch, setback, -1], "Z", hole_d / 2.0 + 0.05, t + 2.0)); }
strip + fence - compound(cuts)
