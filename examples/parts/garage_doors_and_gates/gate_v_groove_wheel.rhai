// Sliding gate V-groove wheel: 80 mm wheel 32 mm wide with a 90 degree V groove 10 mm deep for angle track, 20 mm bore with 47 mm bearing seats (6204) 14 mm deep both sides
let od = 80.0; // [80.0, 120.0] Wheel diameter (mm)
let width = 32.0; // [32.0, 45.0] Wheel width (mm)
let groove = 10.0; // [6.0, 13.0] V groove depth (mm)
let r = od / 2.0;
let h = width / 2.0;
let prof = polygon([[23.5, 0, -h], [r, 0, -h], [r, 0, -groove], [r - groove, 0, 0], [r, 0, groove], [r, 0, h], [23.5, 0, h]]);
let w = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let web = cylinder([0, 0, -h + 14.0], "Z", 23.51, width - 28.0) - cylinder([0, 0, -h], "Z", 12.0, width);
w + web
