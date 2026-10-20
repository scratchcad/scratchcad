// Flying disc 175 mm (ultimate size): 175 mm OD, 32 mm rim height, 1.6 mm flight plate, 10 mm wide rim with a straight-segment lip profile, open underneath
let dia = 175.0; // [150.0, 230.0] Disc diameter (mm)
let rim_h = 32.0; // [20.0, 40.0] Rim height (mm)
let r = dia / 2.0;
let prof = polygon([[0, 0, rim_h], [r - 6.0, 0, rim_h], [r, 0, rim_h - 6.0], [r, 0, 4.0], [r - 3.0, 0, 0], [r - 10.0, 0, 0], [r - 10.0, 0, 3.0], [r - 3.0, 0, 6.0], [r - 3.0, 0, rim_h - 7.0], [r - 7.0, 0, rim_h - 1.6], [0, 0, rim_h - 1.6]]);
face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0)
