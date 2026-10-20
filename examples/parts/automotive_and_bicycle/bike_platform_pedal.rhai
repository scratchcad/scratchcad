// Flat MTB platform pedal body: 100 x 100 x 14 mm, two windows, 22 mm spindle boss, ten 3 mm traction pins per side
let size = 100.0; // [85.0, 115.0] Platform size (mm)
let thick = 14.0; // [10.0, 18.0] Body thickness (mm)
let body = box_centered(size, size, thick).fillet(6.0, "|Z");
let win_w = size - 30.0;
let win_d = size / 2.0 - 22.0;
for s in [-1.0, 1.0] { body -= box_centered(win_w, win_d, thick + 2.0).translate([0, s * (12.0 + win_d / 2.0), 0]); }
let pedal = body + cylinder([-size / 2.0 - 6.0, 0, 0], "X", 11.0, size + 6.0) - cylinder([-size / 2.0 - 7.0, 0, 0], "X", 5.0, size + 8.0);
let pins = [];
for x in [-40.0, -20.0, 0.0, 20.0, 40.0] {
    for y in [-size / 2.0 + 5.0, size / 2.0 - 5.0] {
        pins.push(cylinder([x, y, thick / 2.0 - 1.0], "Z", 1.5, 5.0));
        pins.push(cylinder([x, y, -thick / 2.0 - 4.0], "Z", 1.5, 5.0));
    }
}
fuse_all([pedal] + pins)
