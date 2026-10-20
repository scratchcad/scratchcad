// Microtube cap opener: 80 mm lever 15 mm wide, 3 mm thick, with a 1.5 mm hooked lip 4 mm deep at one end to flip 1.5 ml tube caps and a 10 mm thumb dimple
let length = 80.0; // [60.0, 110.0] Opener length (mm)
let width = 15.0; // [12.0, 20.0] Opener width (mm)
const t = 3.0;
let lever = box_from_corners([0, 0, 0], [length, width, t]);
let lever = lever.fillet(5.0, lever.edges("|Z and >X"));
let hook = box_from_corners([-1.5, 0, -4.0], [0.01, width, t]) + box_from_corners([-1.5, 0, -4.0], [3.0, width, -2.5]);
lever + hook - sphere([length - 20.0, width / 2.0, t + 8.0], 9.0)
