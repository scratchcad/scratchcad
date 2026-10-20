// Parallel dowel pin ISO 2338 8 x 30 m6, unhardened: 8 mm diameter, 30 mm long, both ends chamfered 1.2 mm
let diameter = 8.0; // [1.0, 30.0] Pin diameter (mm)
let length = 30.0; // [4.0, 150.0] Length (mm)
let end_chamfer = 1.2; // [0.1, 3.5] End chamfer (mm)
let r = diameter / 2.0;
cylinder(r, length).chamfer(min(end_chamfer, r * 0.4), "%CIRCLE")
