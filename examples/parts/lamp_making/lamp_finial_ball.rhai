// Lamp shade finial: 30 mm faceted finial 40 mm tall from a straight-segment revolve profile, with a 1/4-27 tapped boss (5.6 mm) 10 mm deep underneath
let height = 40.0; // [25.0, 60.0] Finial height (mm)
let dia = 30.0; // [20.0, 40.0] Finial diameter (mm)
let r = dia / 2.0;
let prof = polygon([[0, 0, 0], [6.0, 0, 0], [6.0, 0, 3.0], [4.0, 0, 6.0], [r, 0, height * 0.35], [r, 0, height * 0.55], [r * 0.5, 0, height * 0.85], [2.0, 0, height], [0, 0, height]]);
face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0) - cylinder([0, 0, -1.0], "Z", 2.8, 11.0)
