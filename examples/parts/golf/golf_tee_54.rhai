// Golf tee 2-1/8 inch (54 mm): 10 mm head 6 mm tall with a 3 mm deep conical ball seat, 4.5 mm shank tapering to a 1.2 mm point over the last 12 mm
let length = 54.0; // [38.0, 83.0] Tee length (mm)
let cup = 10.0; // [8.0, 13.0] Cup diameter (mm)
const shank = 4.5;
let head = cone(shank / 2.0, cup / 2.0, 6.0).translate([0, 0, length - 6.0]);
let stem = cylinder([0, 0, 12.0], "Z", shank / 2.0, length - 18.0 + 0.01);
let tip = cone(0.6, shank / 2.0, 12.01);
let seat = cone(0.5, cup / 2.0 - 0.8, 3.0).translate([0, 0, length - 2.99]);
head + stem + tip - seat
