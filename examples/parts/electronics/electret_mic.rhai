// 9.7 x 6.7 mm electret microphone capsule: felt-covered face with a 2.5 mm acoustic port, 2 solder pads on the back
let diameter = 9.7; // [4.0, 12.0] Diameter (mm)
let height = 6.7; // [1.5, 8.0] Height (mm)
let can = cylinder(diameter / 2.0, height).chamfer(0.3, ">Z") - cylinder([0, 0, height - 0.3], "Z", diameter / 2.0 - 0.6, 1.0);
let felt = cylinder([0, 0, height - 0.3], "Z", diameter / 2.0 - 0.6, 0.25) - cylinder([0, 0, height - 1], "Z", 1.25, 2.0);
let pads = cylinder([-1.5, 0, -0.2], "Z", 0.8, 0.21) + cylinder([1.5, 0, -0.2], "Z", 0.8, 0.21);
fuse_all([can, felt, pads])
