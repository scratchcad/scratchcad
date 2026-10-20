// Garage door track roller: 2 inch (51 mm) nylon wheel 18 mm wide with a straight-segment crowned tread, 7/16 inch (11.1 mm) stem 100 mm long and a 25 mm hub boss
let wheel = 51.0; // [44.0, 64.0] Wheel diameter (mm)
let stem_l = 100.0; // [60.0, 150.0] Stem length (mm)
const width = 18.0;
let r = wheel / 2.0;
let prof = polygon([[5.0, 0, 0], [r - 2.0, 0, 0], [r, 0, 3.0], [r, 0, width - 3.0], [r - 2.0, 0, width], [5.0, 0, width]]);
let w = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let hub = cylinder([0, 0, width - 0.01], "Z", 12.5, 6.0);
let stem = cylinder([0, 0, 0], "Z", 5.55, stem_l);
w + hub + stem
