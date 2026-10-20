// Non-spill water bowl ring: floats inside a 200 mm bowl, 196 mm OD ring 20 mm tall with 3 mm walls and a flat inward lip 3 mm thick leaving a 140 mm drinking opening
let bowl = 196.0; // [180.0, 260.0] Ring outer diameter (mm)
let opening = 140.0; // [90.0, 160.0] Drinking opening (mm)
const wall = 3.0;
let r = bowl / 2.0;
let ring = cylinder([0, 0, 0], "Z", r, 20.0) - cylinder([0, 0, -1.0], "Z", r - wall, 22.0);
let lip = cylinder([0, 0, 20.0 - wall], "Z", r - wall + 0.01, wall) - cylinder([0, 0, 15.0], "Z", opening / 2.0, 10.0);
ring + lip
