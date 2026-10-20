// Picnic ground-spike cup holder: 80 mm cup ring 20 mm tall with 2.5 mm walls and a 6 mm drain hole, on a 200 mm tapered 10 mm spike
let cup = 80.0; // [60.0, 100.0] Cup diameter (mm)
let spike = 200.0; // [120.0, 300.0] Spike length (mm)
const wall = 2.5;
let r = cup / 2.0 + 0.5;
let ring = cylinder([0, 0, 0], "Z", r + wall, 20.0) - cylinder([0, 0, wall], "Z", r, 20.0) - cylinder([r * 0.5, 0, -1.0], "Z", 3.0, wall + 2.0);
let s = cone(1.0, 5.0, spike).translate([0, 0, -spike + 0.01]);
ring + s
