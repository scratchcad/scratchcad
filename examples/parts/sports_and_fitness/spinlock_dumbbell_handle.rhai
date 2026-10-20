// Standard 1 in spin-lock dumbbell handle: 25 mm bar 355 mm long, 150 mm knurled grip, 30 mm inner collars 15 mm wide, 85 mm threaded sleeves each end (4 mm pitch)
let length = 355.0; // [300.0, 450.0] Overall length (mm)
let bar_d = 25.0; // [22.0, 30.0] Bar diameter (mm)
let grip_length = 150.0; // [100.0, 200.0] Grip length (mm)
let collar_d = 34.0; // [28.0, 45.0] Inner collar diameter (mm)
let pitch = 4.0; // [2.5, 6.0] Thread pitch (mm)
const collar_w = 15.0;
const knurl_pitch = 3.0;
let r = bar_d / 2.0;
let half = length / 2.0;
let x_collar = grip_length / 2.0;
let x_thread = x_collar + collar_w;
let rc = max(collar_d / 2.0, r + 2.0);
// half profile from the centre (x = 0) to the right end, revolved about X
let prof = [[0.0, 0.0], [0.0, r - 0.5], [x_collar, r - 0.5], [x_collar, rc], [x_thread, rc], [x_thread, r]];
let turns = ((half - x_thread - 2.0) / pitch).floor().to_int();
for i in 0..turns {
    prof.push([x_thread + (i.to_float() + 0.5) * pitch, r - 1.6]);
    prof.push([x_thread + (i.to_float() + 1.0) * pitch, r]);
}
prof.push([half - 1.0, r]);
prof.push([half, r - 1.0]);
prof.push([half, 0.0]);
let right = polygon("XY", prof).to_face().revolve("X", 360);
let handle = right + right.mirror("YZ");
let rings = [];
let n = (grip_length / knurl_pitch).floor().to_int() - 2;
for i in 0..n {
    let x = -grip_length / 2.0 + (i.to_float() + 1.5) * knurl_pitch;
    rings.push(cylinder([x, 0, 0], "X", r, 1.0) - cylinder([x - 1.0, 0, 0], "X", r - 1.0, 3.0));
}
handle - compound(rings)
