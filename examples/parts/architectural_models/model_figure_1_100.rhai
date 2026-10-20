// 1:100 scale figure: 17.5 mm standing person (1.75 m) as a simplified block figure, 4 mm wide shoulders, 2.4 mm head, on a 5 mm base 0.8 mm thick
let height = 17.5; // [12.0, 25.0] Figure height (mm)
let s = height / 17.5;
let base = cylinder([0, 0, 0], "Z", 2.5, 0.8);
let legs = box_centered(2.2 * s, 1.2 * s, 8.0 * s).translate([0, 0, 0.79 + 4.0 * s]);
let torso = box_centered(4.0 * s, 1.6 * s, 6.0 * s).translate([0, 0, 0.79 + 8.0 * s + 3.0 * s - 0.01]);
let head = sphere([0, 0, 0.79 + 14.0 * s + 1.2 * s], 1.2 * s + 0.2);
base + legs + torso + head
