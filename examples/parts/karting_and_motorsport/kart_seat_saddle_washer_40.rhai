// Kart seat mounting saddle washer: 40 mm round washer 3 mm thick, curved to sit on a seat shell of 200 mm radius, with an 8.5 mm hole for an M8 seat bolt and 0.5 mm edge chamfers
let washer_d = 40.0; // [25.0, 60.0] Washer diameter (mm)
let seat_r = 200.0; // [80.0, 400.0] Seat curvature radius (mm)
let thickness = 3.0; // [2.0, 5.0] Washer thickness (mm)
let bolt_d = 8.0; // [6.0, 10.0] Bolt diameter (mm)
let disc = cylinder([0, 0, -10.0], "Z", washer_d / 2.0, 20.0);
let disc = disc.chamfer(0.5, disc.edges("%CIRCLE"));
let shell = cylinder([-washer_d, 0, seat_r], "X", seat_r + thickness, 2.0 * washer_d) - cylinder([-washer_d - 1.0, 0, seat_r], "X", seat_r, 2.0 * washer_d + 2.0);
let washer = (disc & shell).translate([0, 0, thickness]);
washer - cylinder([0, 0, -5.0], "Z", bolt_d / 2.0 + 0.25, 30.0)
