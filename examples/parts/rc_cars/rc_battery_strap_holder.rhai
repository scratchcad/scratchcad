// RC car battery strap holder: 25 x 15 mm base 3 mm with two M3 holes and a 20 x 3 mm strap slot loop 8 mm tall for a 20 mm velcro strap
let strap = 20.0; // [12.0, 30.0] Strap width (mm)
let base_l = 25.0; // [18.0, 40.0] Base length (mm)
const t = 3.0;
let w = strap + 8.0;
let b = box_centered(base_l, w, t).translate([0, 0, t / 2.0]);
let loop_ = box_centered(6.0, w, 8.0).translate([0, 0, t + 4.0 - 0.01]) - box_centered(8.0, strap + 0.5, 3.0).translate([0, 0, t + 3.5]);
b + loop_ - cylinder([-base_l / 2.0 + 4.0, 0, -1.0], "Z", 1.6, t + 2.0) - cylinder([base_l / 2.0 - 4.0, 0, -1.0], "Z", 1.6, t + 2.0)
