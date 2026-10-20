// Desk phone stand: back rest 100 mm long leaning back at 70 degrees, 80 mm wide, 12 mm phone ledge with a 14 mm front lip, a 10 mm centre brace and a 12 x 8 mm charging cable slot through the ledge
let width = 80.0; // [60.0, 110.0] Stand width (mm)
let ledge = 12.0; // [9.0, 18.0] Phone thickness ledge (mm)
let angle = 70.0; // [55.0, 80.0] Back rest angle (degrees)
const t = 5.0;
const back_len = 100.0;
let a = angle * PI() / 180.0;
let c = cos(a);
let s = sin(a);
const x0 = 20.0;
let back = face(polygon([[x0, 0, 0], [x0 + t / s, 0, 0], [x0 + t / s + back_len * c, 0, back_len * s], [x0 + back_len * c, 0, back_len * s]])).extrude([0, width, 0]);
let base = box_from_corners([x0 - ledge - t, 0, 0], [x0 + back_len * c + 30.0, width, t]);
let lip = box_from_corners([x0 - ledge - t, 0, t - 0.01], [x0 - ledge, width, 14.0]);
let bx = x0 + 0.6 * back_len * c;
let brace = face(polygon([[x0 + 1.0, 0, t - 0.01], [bx + 28.0, 0, t - 0.01], [bx + 2.0, 0, 0.6 * back_len * s]])).extrude([0, 10.0, 0]).translate([0, width / 2.0 - 5.0, 0]);
let st = back + base + lip + brace;
st - box_from_corners([x0 - ledge, width / 2.0 - 6.0, -1.0], [x0 - ledge + 8.0, width / 2.0 + 6.0, t + 1.0])
