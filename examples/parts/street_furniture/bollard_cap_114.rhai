// Steel bollard top cap: for 114.3 mm OD bollard tube, 120 mm cap 15 mm skirt, 30 mm conical top (straight cone), 3 mm walls, with a 25 mm reflective band groove 1 mm deep
let tube = 114.3; // [76.1, 168.3] Bollard tube OD (mm)
let skirt = 15.0; // [10.0, 30.0] Skirt depth (mm)
const wall = 3.0;
let r = tube / 2.0 + 0.5;
let s = cylinder([0, 0, 0], "Z", r + wall, skirt) - cylinder([0, 0, -1.0], "Z", r, skirt + 1.0 - wall);
let top = cone(r + wall, 10.0, 30.0).translate([0, 0, skirt - 0.01]);
let band = cylinder([0, 0, 3.0], "Z", r + wall + 1.0, 8.0) - cylinder([0, 0, 2.0], "Z", r + wall - 1.0, 10.0);
s + top - band
