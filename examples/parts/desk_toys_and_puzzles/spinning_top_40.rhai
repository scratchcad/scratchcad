// Desk spinning top: 40 mm faceted body 12 mm thick from a straight-segment profile, 8 mm cone tip below and a 6 mm stem 15 mm tall with a 1 mm grip flat
let dia = 40.0; // [25.0, 60.0] Top diameter (mm)
let stem = 15.0; // [8.0, 25.0] Stem height (mm)
let r = dia / 2.0;
let prof = polygon([[0, 0, 0], [3.0, 0, 6.0], [r, 0, 10.0], [r, 0, 14.0], [6.0, 0, 18.0], [3.0, 0, 18.0], [3.0, 0, 18.0 + stem], [0, 0, 18.0 + stem]]);
face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0) - box_from_corners([2.0, -5.0, 22.0], [5.0, 5.0, 18.0 + stem + 1.0])
