// Go stone (slate-and-shell style): 22 mm diameter, 9 mm thick biconvex lens made from two spherical caps
let d = 22.0; // [18.0, 24.0] Diameter (mm)
let t = 9.0; // [5.0, 12.0] Thickness (mm)
let h = t / 2.0;
let R = (d * d / 4.0 + h * h) / (2.0 * h);
sphere([0, 0, h - R], R) & sphere([0, 0, R - h], R)
