// Skateboard wheel 54 mm x 32 mm with a 20 mm contact patch, 608 bearing seats 22 x 7 mm each side, 10 mm spacer bore and chamfered lips
let od = 54.0; // [50.0, 60.0] Wheel diameter (mm)
let width = 32.0; // [28.0, 40.0] Wheel width (mm)
let contact = 20.0; // [14.0, 26.0] Contact patch width (mm)
const seat_d = 22.0;
const seat_w = 7.0;
let r = od / 2.0;
let h = width / 2.0;
let c = contact / 2.0;
let profile = polygon([[seat_d / 2.0 + 1.0, 0, -h], [r - 3.0, 0, -h], [r, 0, -c], [r, 0, c], [r - 3.0, 0, h], [seat_d / 2.0 + 1.0, 0, h]]);
let rim = face(profile).revolve([0, 0, 0], [0, 0, 1], 360.0);
let core = cylinder([0, 0, -h], "Z", seat_d / 2.0 + 1.01, width) - cylinder([0, 0, -h - 1.0], "Z", seat_d / 2.0, seat_w + 1.0) - cylinder([0, 0, h - seat_w], "Z", seat_d / 2.0, seat_w + 1.0) - cylinder([0, 0, -h], "Z", 5.0, width);
rim + core
