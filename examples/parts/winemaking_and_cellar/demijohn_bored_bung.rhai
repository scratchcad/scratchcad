// Demijohn bored bung: tapered 34 to 27 mm over 30 mm for a 1 gallon demijohn neck, 9 mm airlock bore and a 38 mm grip lip 3 mm thick
let top_d = 34.0; // [30.0, 40.0] Top diameter (mm)
let bottom_d = 27.0; // [22.0, 29.0] Bottom diameter (mm)
let bore = 9.0; // [6.0, 12.0] Airlock stem bore (mm)
const length = 30.0;
let b = cone(bottom_d / 2.0, top_d / 2.0, length) + cylinder([0, 0, length - 0.01], "Z", top_d / 2.0 + 2.0, 3.0);
b - cylinder([0, 0, -1.0], "Z", bore / 2.0, length + 5.0)
