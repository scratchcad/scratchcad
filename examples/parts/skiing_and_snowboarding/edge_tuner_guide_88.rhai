// Ski edge tuning guide, 88 degree side edge: 100 mm long angle block 40 x 30 mm with an 88 degree file face, a 25 x 4 mm file clamp slot and a 3 mm file screw hole
let length = 100.0; // [70.0, 140.0] Guide length (mm)
let angle = 88.0; // [86.0, 90.0] Edge angle (degrees)
let a = (90.0 - angle) * PI() / 180.0;
let prof = polygon([[0, 0, 0], [40.0, 0, 0], [40.0 + 30.0 * a.sin() / a.cos(), 0, 30.0], [0, 0, 30.0]]);
let g = face(prof).extrude([0, length, 0]);
g - box_from_corners([5.0, 10.0, 26.0], [30.0, length - 10.0, 31.0]) - cylinder([17.5, length / 2.0, -1.0], "Z", 1.5, 40.0)
