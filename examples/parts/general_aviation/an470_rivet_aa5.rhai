// AN470AD5-8 universal head rivet: 5/32 in (3.97 mm) shank, 1/2 in long, head 2 x D wide 0.425 D tall
let d = 3.97; // [2.38, 6.35] Shank diameter (mm)
let length = 12.7; // [4.0, 25.0] Shank length (mm)
const k_head = 2.0;
let hd = k_head * d;
let hh = 0.425 * d;
let rs = (hd * hd / 4.0 + hh * hh) / (2.0 * hh);
let head = sphere([0, 0, hh - rs], rs) & cylinder(hd / 2.0, hh);
head + cylinder([0, 0, -length], "Z", d / 2.0, length + 0.01)
