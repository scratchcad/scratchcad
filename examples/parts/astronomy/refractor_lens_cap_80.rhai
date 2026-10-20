// Lens cap for an 80 mm refractor dew shield: 92 mm ID, 3 mm wall, 18 mm skirt with a 40 mm aperture-mask hole ringed by a 4 mm collar for a push-in plug
let id = 92.0; // [70.0, 130.0] Dew shield OD to fit (mm)
let skirt = 18.0; // [10.0, 30.0] Skirt depth (mm)
let mask = 40.0; // [20.0, 55.0] Aperture mask hole diameter (mm)
const wall = 3.0;
let cap = cylinder([0, 0, 0], "Z", id / 2.0 + wall, skirt + wall) - cylinder([0, 0, wall], "Z", id / 2.0, skirt + 1.0);
let collar = cylinder([0, 0, -3.99], "Z", mask / 2.0 + 4.0, 4.0);
cap + collar - cylinder([0, 0, -5.0], "Z", mask / 2.0, wall + 6.0)
