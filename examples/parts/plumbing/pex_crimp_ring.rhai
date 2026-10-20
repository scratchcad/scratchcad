// 1/2 in PEX copper crimp ring: 18.4 mm OD, 16.9 mm ID, 7.9 mm long, with a visible crimp band
let outer_d = 18.4; // [17.6, 35.0] Outside diameter (mm)
let inner_d = 16.9; // [10.0, 17.7] Inside diameter (mm)
let length = 7.9; // [5.0, 12.0] Length (mm)
let ring = cylinder(outer_d / 2.0, length) - cylinder([0, 0, -1], "Z", inner_d / 2.0, length + 2.0);
ring - (cylinder([0, 0, length / 2.0 - 1.0], "Z", outer_d / 2.0 + 1.0, 2.0) - cylinder([0, 0, 0], "Z", outer_d / 2.0 - 0.25, length))
