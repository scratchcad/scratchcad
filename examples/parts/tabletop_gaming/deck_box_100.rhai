// Trading card deck box for 100 sleeved cards: 72 x 98 x 70 mm inside, 2 mm walls, thumb notch 25 mm
let w = 72.0; // [66.0, 80.0] Inside width (mm)
let h = 98.0; // [91.0, 105.0] Inside height (mm)
let d = 70.0; // [20.0, 100.0] Inside depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let outer = box_from_corners([0, 0, 0], [w + 2.0 * wall, d + 2.0 * wall, h + wall]);
let o = outer.fillet(3.0, outer.edges("|Z"));
let inner = box_from_corners([wall, wall, wall], [w + wall, d + wall, h + wall + 1.0]);
let notch = cylinder([(w + 2.0 * wall) / 2.0, -1, h + wall], "Y", 12.5, d + 2.0 * wall + 2.0);
o - inner - notch
