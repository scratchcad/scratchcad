// Commercial HDPE cutting board foot: 30 mm diameter, 10 mm tall tapered rubber foot to 26 mm at the floor, 4.2 mm screw hole with a 9 mm counterbore 4 mm deep from the floor side
let top_d = 30.0; // [20.0, 40.0] Top diameter (mm)
let height = 10.0; // [6.0, 16.0] Foot height (mm)
let screw = 4.2; // [3.0, 5.0] Screw hole diameter (mm)
const cb_d = 9.0;
const cb_depth = 4.0;
let foot = face(polygon([[0, 0, 0], [top_d / 2.0 - 2.0, 0, 0], [top_d / 2.0, 0, 2.0], [top_d / 2.0, 0, height], [0, 0, height]])).revolve("Z", 360);
foot - cylinder([0, 0, -1.0], "Z", screw / 2.0, height + 2.0) - cylinder([0, 0, -1.0], "Z", cb_d / 2.0, cb_depth + 1.0)
