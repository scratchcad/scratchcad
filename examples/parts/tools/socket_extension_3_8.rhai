// 3/8 in drive socket extension, 150 mm: 9.53 mm square male drive with ball detent, 17 mm female end, 12 mm shaft
let len = 150.0; // [50.0, 300.0] Length (mm)
let female = cylinder(8.5, 20.0).chamfer(0.6, "<Z") - box_centered(9.6, 9.6, 22.0);
let shaft = cylinder([0, 0, 19.0], "Z", 6.0, len - 32.0);
let male = box_centered(9.53, 9.53, 13.0).translate([0, 0, len - 6.5]).chamfer(0.5, ">Z") + cylinder([0, 0, len - 14.0], "Z", 7.0, 2.0);
fuse_all([female, shaft, male, sphere([4.76, 0, len - 5.0], 1.2)])
