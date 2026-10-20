// Oxygen cylinder holder ring for a CD-size (102 mm) cylinder on a bed or trolley: 107 mm bore, 5 mm wall, 30 mm tall, with a 60 x 40 x 6 mm mounting tab and two 6.5 mm bolt holes 40 mm apart
let cyl_d = 102.0; // [80.0, 140.0] Cylinder diameter (mm)
let height = 30.0; // [20.0, 50.0] Ring height (mm)
let wall = 5.0; // [3.0, 8.0] Ring wall (mm)
const tab_t = 6.0;
let ri = cyl_d / 2.0 + 2.5;
let ro = ri + wall;
let ring = cylinder([0, 0, 0], "Z", ro, height);
let tab = box_from_corners([-30.0, -ro - tab_t, 0], [30.0, -ri, max(height, 40.0)]);
let h = ring + tab - cylinder([0, 0, -1.0], "Z", ri, max(height, 40.0) + 2.0);
h - cylinder([-20.0, -ro - tab_t - 1.0, max(height, 40.0) / 2.0], "Y", 3.25, wall + tab_t) - cylinder([20.0, -ro - tab_t - 1.0, max(height, 40.0) / 2.0], "Y", 3.25, wall + tab_t)
