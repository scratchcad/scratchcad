// Oak barrel bung: tapered 55 to 47 mm over 40 mm for a standard 2 inch bung hole, a 60 mm stop lip and a 33 x 8 mm pull handle on top with a 22 mm finger slot
let top_d = 55.0; // [45.0, 65.0] Top diameter (mm)
let length = 40.0; // [30.0, 55.0] Bung length (mm)
const taper = 8.0;
let b = cone(top_d / 2.0 - taper / 2.0, top_d / 2.0, length) + cylinder([0, 0, length - 0.01], "Z", top_d / 2.0 + 2.5, 6.0);
let pull = box_centered(top_d * 0.6, 8.0, 10.0).translate([0, 0, length + 6.0 + 5.0 - 0.01]);
b + pull - box_centered(top_d * 0.4, 9.0, 6.0).translate([0, 0, length + 6.0 + 7.0])
