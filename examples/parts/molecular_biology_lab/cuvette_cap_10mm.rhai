// Spectrophotometer cuvette cap: push-on cap for a 12.5 x 12.5 mm cuvette, 15 x 15 mm outer, 10 mm skirt, 1.2 mm walls with a 4 mm grip tab on top
let cuvette = 12.5; // [12.3, 12.7] Cuvette outer size (mm)
let skirt = 10.0; // [6.0, 15.0] Skirt depth (mm)
const wall = 1.2;
let o = cuvette + 0.2 + 2.0 * wall;
let cap = box_centered(o, o, skirt + wall).translate([0, 0, (skirt + wall) / 2.0]) - box_centered(cuvette + 0.2, cuvette + 0.2, skirt + 1.0).translate([0, 0, (skirt + 1.0) / 2.0 - 1.0]);
let tab = box_centered(8.0, 1.5, 4.0).translate([0, 0, skirt + wall + 2.0 - 0.01]);
cap + tab
