// Dinghy rudder pintle: 6 mm pin 30 mm long on a 60 x 25 mm strap plate 3 mm, 3 countersunk holes
let pin = 6.0; // [5.0, 10.0] Pin diameter (mm)
let pin_l = 30.0; // [20.0, 45.0] Pin length (mm)
let length = 60.0; // [40.0, 80.0] Plate length (mm)
let width = 25.0; // [18.0, 35.0] Plate width (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let p = plate.fillet(width / 2.0 - 0.5, plate.edges("|Z and >X"));
let knuckle = box_from_corners([-12.0, -6.0, 0], [0.01, 6.0, t]) + cylinder([-12.0, 0, 0], "Z", 6.0, t);
let pn = cylinder([-12.0, 0, -pin_l], "Z", pin / 2.0, pin_l + t);
let holes = [];
for x in [15.0, 32.0, 49.0] { holes.push(cylinder([x, 0, -1], "Z", 2.25, t + 2.0) + cone(2.25, 4.5, 2.25).translate([x, 0, t - 2.24])); }
p + knuckle + pn.chamfer(0.8, pn.edges("<Z")) - fuse_all(holes)
