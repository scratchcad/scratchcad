// Sports medal: 50 mm disc 4 mm thick with a 2 mm raised rim 3 mm wide, a 25 mm recessed insert pocket 1 mm deep and a 10 x 4 mm ribbon loop with a 22 mm ribbon slot
let dia = 50.0; // [40.0, 70.0] Medal diameter (mm)
let insert = 25.0; // [15.0, 35.0] Insert disc diameter (mm)
const t = 4.0;
let d = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let rim = cylinder([0, 0, t - 0.01], "Z", dia / 2.0, 1.0) - cylinder([0, 0, t - 1.0], "Z", dia / 2.0 - 3.0, 3.0);
let loop_ = box_from_corners([-14.0, dia / 2.0 - 2.0, 0], [14.0, dia / 2.0 + 8.0, t]) - box_from_corners([-11.0, dia / 2.0 + 2.0, -1.0], [11.0, dia / 2.0 + 6.0, t + 1.0]);
d + rim + loop_ - cylinder([0, 0, t - 1.0], "Z", insert / 2.0, 2.0)
