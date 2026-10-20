// 22 mm pilot light lens: 29 mm flange 3 mm, 21.5 mm domed lens 8 mm, 2 snap tabs into a 22.3 mm bezel
let flange = 29.0; // [24.0, 36.0] Flange diameter (mm)
let lens = 21.5; // [16.0, 28.0] Lens diameter (mm)
let dome_h = 8.0; // [4.0, 12.0] Dome height (mm)
let rs = (lens * lens / 4.0 + dome_h * dome_h) / (2.0 * dome_h);
let dome = sphere([0, 0, 3.0 + dome_h - rs], rs) & cylinder([0, 0, 2.99], "Z", lens / 2.0, dome_h);
let f = cylinder(flange / 2.0, 3.0);
let tabs = box_from_corners([-2.0, lens / 2.0 - 2.0, -5.0], [2.0, lens / 2.0, 0.01]) + box_from_corners([-2.0, -lens / 2.0, -5.0], [2.0, -lens / 2.0 + 2.0, 0.01]);
f + dome + tabs
