// Wall-mounted tongue depressor dispenser: gravity magazine for 150 x 18 mm wooden depressors, inside 153 x 21 mm, 120 mm tall, 2 mm walls, a 3 mm exit slot along the bottom front with a 40 x 25 mm thumb notch, and two 4.5 mm screw holes in the back
let blade_l = 150.0; // [140.0, 160.0] Depressor length (mm)
let blade_w = 18.0; // [15.0, 25.0] Depressor width (mm)
let height = 120.0; // [80.0, 180.0] Magazine height (mm)
const t = 2.0;
let ix = blade_l + 3.0;
let iy = blade_w + 3.0;
let m = box_from_corners([-ix / 2.0 - t, -t, 0], [ix / 2.0 + t, iy + t, height]);
m = m - box_from_corners([-ix / 2.0, 0, t], [ix / 2.0, iy, height + 1.0]);
m = m - box_from_corners([-ix / 2.0, iy - 1.0, t], [ix / 2.0, iy + t + 1.0, t + 3.0]);
m = m - box_from_corners([-20.0, iy - 1.0, t], [20.0, iy + t + 1.0, 25.0]);
m - cylinder([-ix / 4.0, -t - 1.0, height - 15.0], "Y", 2.25, t + 2.0) - cylinder([ix / 4.0, -t - 1.0, height - 15.0], "Y", 2.25, t + 2.0)
