// Hydraulic hose ferrule for 1/4 in 2-wire hose: 21.5 mm OD, 30 mm long, 1.8 mm wall, 4 internal skive teeth
let od = 21.5; // [15.0, 40.0] Ferrule OD (mm)
let length = 30.0; // [20.0, 50.0] Length (mm)
let wall = 1.8; // [1.2, 3.0] Wall (mm)
let shell = cylinder(od / 2.0, length) - cylinder([0, 0, 2.5], "Z", od / 2.0 - wall, length);
let teeth = [];
for k in 0..4 { teeth.push(cylinder([0, 0, 8.0 + k.to_float() * 5.0], "Z", od / 2.0 - wall + 0.01, 1.5) - cylinder([0, 0, 7.0 + k.to_float() * 5.0], "Z", od / 2.0 - wall - 1.0, 3.5)); }
shell + fuse_all(teeth) - cylinder([0, 0, -1], "Z", 5.0, 4.0)
