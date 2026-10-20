// Camping mess tin pot, 750 ml: 120 mm diameter, 70 mm deep, 1 mm wall, rolled rim, two handle lugs
let diameter = 120.0; // [90.0, 160.0] Diameter (mm)
let depth = 70.0; // [50.0, 100.0] Depth (mm)
let wall = 1.0; // [0.6, 2.0] Wall (mm)
let pot = cylinder(diameter / 2.0, depth);
let p = pot.fillet(8.0, pot.edges("<Z")).shell(-wall, ">Z");
let rim = torus(diameter / 2.0 + 0.5, 1.5).translate([0, 0, depth - 1.0]);
let lugs = [];
for s in [-1.0, 1.0] { lugs.push(box_from_corners([s * (diameter / 2.0 - 0.5), -6.0, depth - 18.0], [s * (diameter / 2.0 + 6.0), 6.0, depth - 10.0]) - cylinder([s * (diameter / 2.0 + 3.0), -10.0, depth - 14.0], "Y", 1.6, 20.0)); }
p + rim + fuse_all(lugs)
