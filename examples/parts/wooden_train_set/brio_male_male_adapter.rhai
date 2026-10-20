// Wooden track male-male adapter peg: two 11.5 mm pegs on 6 mm necks, 30 mm long, 12 mm thick
let t = 12.0; // [10.0, 14.0] Thickness (mm)
let peg = 11.5; // [11.0, 12.0] Peg diameter (mm)
cylinder([-11.0, 0, 0], "Z", peg / 2.0, t) + cylinder([11.0, 0, 0], "Z", peg / 2.0, t) + box_from_corners([-7.0, -3.0, 0], [7.0, 3.0, t])
