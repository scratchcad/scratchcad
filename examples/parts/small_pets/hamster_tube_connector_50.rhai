// Hamster tube connector: joins two 50 mm OD tubes, 54 mm OD sleeve 40 mm long with 2 mm walls, a 2 mm internal stop ring at the middle and 4 vent holes 5 mm
let tube = 50.0; // [40.0, 60.0] Tube OD (mm)
let length = 40.0; // [25.0, 60.0] Sleeve length (mm)
const wall = 2.0;
let s = cylinder([0, 0, 0], "Z", tube / 2.0 + 0.3 + wall, length) - cylinder([0, 0, -1.0], "Z", tube / 2.0 + 0.3, length + 2.0);
let stop = cylinder([0, 0, length / 2.0 - 1.0], "Z", tube / 2.0 + 0.31, 2.0) - cylinder([0, 0, length / 2.0 - 2.0], "Z", tube / 2.0 - 3.0, 4.0);
let vents = cylinder([-tube, 0, length / 2.0 + 8.0], "X", 2.5, 2.0 * tube) + cylinder([0, -tube, length / 2.0 + 8.0], "Y", 2.5, 2.0 * tube);
s + stop - vents
