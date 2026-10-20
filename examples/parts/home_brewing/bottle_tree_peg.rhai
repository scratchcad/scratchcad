// Bottle drying tree peg: 18 mm angled peg 80 mm at 30 degrees up, 25 mm square socket base 20 mm for a 20 mm square spine
let peg = 18.0; // [12.0, 24.0] Peg diameter at the base (mm)
let length = 80.0; // [50.0, 110.0] Peg length (mm)
let spine = 20.0; // [15.0, 30.0] Spine size (mm)
let base = box_centered(spine + 6.0, spine + 6.0, 20.0).translate([0, 0, 10.0]) - box_centered(spine + 0.4, spine + 0.4, 24.0).translate([0, 0, 10.0]);
let p = cone(peg / 2.0, peg / 2.0 - 4.0, length).rotate_y(60.0).translate([spine / 2.0 + 1.0, 0, 10.0]);
base + (p - box_centered(spine + 0.4, spine + 0.4, 24.0).translate([0, 0, 10.0]))
