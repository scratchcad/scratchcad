// Arcade push button bezel: 30 mm button housing for a 28 mm panel hole, 34 mm flange 3 mm, plunger bore leaving 2 mm walls, a 20 mm body stub that takes the panel nut and two microswitch clip lugs
let hole = 28.0; // [24.0, 30.0] Panel hole diameter (mm)
let flange = 34.0; // [30.0, 40.0] Flange diameter (mm)
let b = cylinder([0, 0, 0], "Z", flange / 2.0, 3.0) + cylinder([0, 0, -20.0], "Z", hole / 2.0 - 0.3, 20.01);
let lugs = box_from_corners([-hole / 2.0 - 1.0, -3.0, -20.0], [-hole / 2.0 + 2.0, 3.0, -14.0]) + box_from_corners([hole / 2.0 - 2.0, -3.0, -20.0], [hole / 2.0 + 1.0, 3.0, -14.0]);
b + lugs - cylinder([0, 0, -21.0], "Z", hole / 2.0 - 2.3, 25.0)
