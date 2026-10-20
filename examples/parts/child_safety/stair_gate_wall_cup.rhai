// Pressure stair gate wall cup: 50 mm round cup 4 mm thick with an 18 mm socket 6 mm deep for the gate spindle pad and two 4 mm countersunk screw holes
let dia = 50.0; // [40.0, 70.0] Cup diameter (mm)
let socket = 18.0; // [12.0, 30.0] Spindle pad diameter (mm)
const t = 4.0;
let c = cylinder([0, 0, 0], "Z", dia / 2.0, t) + cylinder([0, 0, t - 0.01], "Z", socket / 2.0 + 3.0, 6.0);
let holes = [cylinder([0, 0, t], "Z", socket / 2.0 + 0.3, 7.0)];
for x in [-dia / 2.0 + 7.0, dia / 2.0 - 7.0] { holes.push(cylinder([x, 0, -1.0], "Z", 2.0, t + 2.0)); holes.push(cone(2.0, 4.0, 2.0).translate([x, 0, t - 1.99])); }
c - fuse_all(holes)
