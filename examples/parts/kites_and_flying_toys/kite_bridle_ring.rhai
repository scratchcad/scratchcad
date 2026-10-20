// Kite bridle towing ring: 20 mm OD ring of 3 mm square section with a 3 mm line-tie lug, sized for 50 kg dyneema
let od = 20.0; // [12.0, 30.0] Ring OD (mm)
let s = 3.0; // [2.0, 5.0] Section (mm)
let ring = cylinder([0, 0, 0], "Z", od / 2.0, s) - cylinder([0, 0, -1.0], "Z", od / 2.0 - s, s + 2.0);
let lug = box_from_corners([od / 2.0 - 0.5, -s, 0], [od / 2.0 + s * 2.0, s, s]) - cylinder([od / 2.0 + s, 0, -1.0], "Z", s / 2.0, s + 2.0);
ring + lug
