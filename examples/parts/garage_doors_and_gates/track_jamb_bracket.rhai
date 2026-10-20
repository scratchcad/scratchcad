// Garage door track jamb bracket: 3 mm steel angle 150 mm long, 50 mm wall flange with two 8 x 20 mm adjustment slots and a 40 mm track flange with two 8 mm holes
let length = 150.0; // [100.0, 250.0] Bracket length (mm)
let flange = 50.0; // [35.0, 70.0] Wall flange width (mm)
const t = 3.0;
let a = box_from_corners([0, 0, 0], [length, flange, t]) + box_from_corners([0, flange - t, 0], [length, flange, 40.0]);
let cuts = [];
for x in [length * 0.25, length * 0.75] {
    cuts.push(box_centered(20.0, 8.0, t + 2.0).translate([x, flange / 2.0 - 5.0, t / 2.0]) + cylinder([x - 10.0, flange / 2.0 - 5.0, -1.0], "Z", 4.0, t + 2.0) + cylinder([x + 10.0, flange / 2.0 - 5.0, -1.0], "Z", 4.0, t + 2.0));
    cuts.push(cylinder([x, flange - t - 1.0, 25.0], "Y", 4.0, t + 2.0));
}
a - fuse_all(cuts)
