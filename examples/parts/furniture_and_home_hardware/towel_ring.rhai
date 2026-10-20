// Towel ring: 160 mm ring of 12 mm rod hanging from a 60 mm wall rosette 12 mm deep by a 16 mm block
let ring_d = 160.0; // [100.0, 220.0] Ring diameter (mm)
let rod = 6.0; // [4.0, 9.0] Rod radius (mm)
let R = ring_d / 2.0;
let rosette = cylinder([0, 0, 0], "Y", 30.0, 12.0).fillet(3.0, ">Y");
let block = box_from_corners([-8.0, 6.0, -20.0], [8.0, 26.0, -2.0]);
let ring = torus(R, rod).rotate_x(90.0).translate([0, 20.0, -R - 15.0]);
fuse_all([rosette, block, ring])
