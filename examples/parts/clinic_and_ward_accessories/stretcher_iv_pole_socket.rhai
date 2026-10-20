// Stretcher IV pole socket: 22.5 mm bore tube 3 mm wall 60 mm long welded to a 50 x 40 x 5 mm mounting plate with two 6.5 mm holes, a 12 mm thumbscrew boss (M6, 5 mm tap) and a 2 mm lead-in chamfer
let pole_d = 22.0; // [16.0, 28.0] Pole diameter (mm)
let length = 60.0; // [40.0, 100.0] Socket length (mm)
let wall = 3.0; // [2.0, 5.0] Tube wall (mm)
const t = 5.0;
let ri = pole_d / 2.0 + 0.25;
let ro = ri + wall;
let tube = cylinder([0, 0, 0], "Z", ro, length);
let plate = box_from_corners([-25.0, -ro - t + 0.5, length / 2.0 - 20.0], [25.0, -ro + 0.5, length / 2.0 + 20.0]);
let boss = cylinder([0, ro - 1.0, length - 15.0], "Y", 6.0, 8.0);
let s = tube + plate + boss;
s = s - cylinder([0, 0, -1.0], "Z", ri, length + 2.0) - cone(ri, ri + 2.0, 2.01).translate([0, 0, length - 2.0]);
s - cylinder([0, ro - 2.0, length - 15.0], "Y", 2.5, 12.0) - cylinder([-17.0, -ro - t - 1.0, length / 2.0], "Y", 3.25, t + 3.0) - cylinder([17.0, -ro - t - 1.0, length / 2.0], "Y", 3.25, t + 3.0)
