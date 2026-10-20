// Conductor's baton handle: 60 mm faceted pear handle 18 mm max, straight-segment profile, with a 3 mm shaft bore 40 mm deep for a 360 mm fibreglass shaft
let length = 60.0; // [45.0, 80.0] Handle length (mm)
let bulb = 18.0; // [14.0, 24.0] Bulb diameter (mm)
let shaft = 3.0; // [2.0, 4.0] Shaft bore (mm)
let r = bulb / 2.0;
let prof = polygon([[0, 0, 0], [r * 0.6, 0, 0], [r, 0, length * 0.15], [r, 0, length * 0.35], [r * 0.6, 0, length * 0.7], [4.0, 0, length], [0, 0, length]]);
face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0) - cylinder([0, 0, length - 40.0], "Z", shaft / 2.0 + 0.05, 41.0)
