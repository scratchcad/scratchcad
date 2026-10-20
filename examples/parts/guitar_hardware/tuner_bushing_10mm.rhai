// Guitar tuner press-in bushing: 10 mm headstock hole, 10.1 mm knurl-free press shank 8 mm long, 12.5 mm flange 1.5 mm thick, 6.2 mm post bore
let hole = 10.0; // [8.0, 11.0] Headstock hole diameter (mm)
let shank = 8.0; // [6.0, 12.0] Shank length (mm)
let post = 6.2; // [5.5, 7.0] Tuner post bore (mm)
let b = cylinder([0, 0, -shank], "Z", hole / 2.0 + 0.05, shank + 0.01) + cylinder([0, 0, 0], "Z", hole / 2.0 + 1.25, 1.5);
let b = b.chamfer(0.3, b.edges("<Z"));
b - cylinder([0, 0, -shank - 1.0], "Z", post / 2.0, shank + 3.0)
