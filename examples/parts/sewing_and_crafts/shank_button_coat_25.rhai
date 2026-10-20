// Coat shank button, 25 mm domed with a 6 mm loop shank and 2 mm thread hole
let diameter = 25.0; // [15.0, 40.0] Diameter (mm)
let dome = 5.0; // [2.0, 8.0] Dome height (mm)
let shank_h = 6.0; // [4.0, 10.0] Shank height (mm)
let rs = (diameter * diameter / 4.0 + dome * dome) / (2.0 * dome);
let cap = sphere([0, 0, dome - rs], rs) & cylinder(diameter / 2.0, dome + 1.0);
let shank = box_from_corners([-2.5, -3.0, -shank_h], [2.5, 3.0, 0.5]);
let s = shank.fillet(1.2, shank.edges("|Y and <Z"));
cap + s - cylinder([0, -5, -shank_h + 2.2], "Y", 1.0, 10.0)
