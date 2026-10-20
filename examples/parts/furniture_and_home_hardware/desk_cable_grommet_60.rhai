// Desk cable grommet, 60 mm hole: 20 mm sleeve with 68 mm lip, separate lid with a 20 mm cable slot
let hole = 60.0; // [40.0, 80.0] Desk hole diameter (mm)
let r = hole / 2.0;
let sleeve = cylinder([0, 0, -20.0], "Z", r, 20.0) + cylinder(r + 4.0, 3.0) - cylinder([0, 0, -21.0], "Z", r - 2.5, 26.0) - cylinder([0, 0, 1.5], "Z", r - 1.5, 2.0);
let lid = cylinder([0, 0, 1.6], "Z", r - 1.6, 1.4) + cylinder([0, 0, -2.0], "Z", r - 2.7, 3.7) - cylinder([0, 0, -3.0], "Z", r - 4.0, 4.0);
lid -= box_from_corners([r - 18.0, -10.0, -3.0], [r + 1.0, 10.0, 4.0]);
compound([sleeve, lid])
