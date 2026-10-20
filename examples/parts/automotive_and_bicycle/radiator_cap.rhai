// Radiator pressure cap, 1.1 bar: 56 mm grip with 8 finger notches, locking skirt with two ears, spring housing, 33 mm seal
let grip = 56.0; // [44.0, 64.0] Grip diameter (mm)
let cap = cylinder([0, 0, 18.0], "Z", grip / 2.0, 8.0);
for k in 0..8 { cap -= cylinder([grip / 2.0 + 1.0, 0, 17.0], "Z", 4.0, 10.0).rotate("Z", k.to_float() * 45.0 + 22.5); }
let skirt = cylinder([0, 0, 11.0], "Z", 27.0, 7.5) - cylinder([0, 0, 10.0], "Z", 25.0, 8.0);
let ears = [box_from_corners([20.0, -5.0, 11.0], [26.0, 5.0, 13.0]), box_from_corners([-26.0, -5.0, 11.0], [-20.0, 5.0, 13.0])];
let spring = cylinder([0, 0, 2.0], "Z", 15.0, 16.5);
let seal = cylinder(16.5, 2.0);
let rivet = cylinder([0, 0, 26.0], "Z", 4.0, 1.5);
fuse_all([cap, skirt, spring, seal, rivet] + ears)
