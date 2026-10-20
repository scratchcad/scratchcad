// Suitcase spinner wheel: 50 mm wheel 18 mm wide with a straight-segment crowned tread, 22 mm 608 bearing seats 7 mm deep both sides and an 8 mm axle bore
let od = 50.0; // [40.0, 70.0] Wheel diameter (mm)
let width = 18.0; // [16.0, 26.0] Wheel width (mm)
let r = od / 2.0;
let h = width / 2.0;
let prof = polygon([[11.0, 0, -h], [r - 2.0, 0, -h], [r, 0, -h + 3.0], [r, 0, h - 3.0], [r - 2.0, 0, h], [11.0, 0, h]]);
let w = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let web = cylinder([0, 0, -h + 7.0], "Z", 11.01, width - 14.0) - cylinder([0, 0, -h], "Z", 4.0, width);
w + web
