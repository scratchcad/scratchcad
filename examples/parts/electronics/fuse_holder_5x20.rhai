// PCB fuse holder for 5 x 20 mm fuses: two clips 9 x 5 x 8 mm, 22.6 mm apart, with the fuse in place
let spacing = 22.6; // [20.0, 30.0] Clip spacing (mm)
let fuse_d = 5.0; // [5.0, 6.35] Fuse diameter (mm)
let fuse_l = 20.0; // [20.0, 32.0] Fuse length (mm)
let clip = box_centered(3.0, 8.0, 9.0).translate([0, 0, 4.5]) - cylinder([-2, 0, 7.0], "X", fuse_d / 2.0, 4.0) - box_centered(4.0, fuse_d * 0.8, 6.0).translate([0, 0, 10.0]);
let fuse = cylinder([-fuse_l / 2.0, 0, 7.0], "X", fuse_d / 2.0, fuse_l);
let glass = cylinder([-fuse_l / 2.0 + 4.0, 0, 7.0], "X", fuse_d / 2.0 - 0.05, fuse_l - 8.0);
[clip.translate([-spacing / 2.0 + 1.5, 0, 0]), clip.translate([spacing / 2.0 - 1.5, 0, 0]), fuse]
