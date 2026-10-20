// Radio dial pointer carriage: 20 x 8 mm slider 4 mm thick riding a 3 mm guide rod, with two 1 mm dial-cord holes and a 40 mm pointer needle 1.2 mm wide
let needle = 40.0; // [25.0, 60.0] Pointer length (mm)
let rod = 3.0; // [2.0, 3.0] Guide rod diameter (mm)
let s = box_centered(20.0, 8.0, 4.0).translate([0, 0, 2.0]);
let n = box_from_corners([-0.6, 3.0, 0], [0.6, 4.0 + needle, 1.5]);
s + n - cylinder([-11.0, 0, 2.0], "X", rod / 2.0 + 0.15, 22.0) - cylinder([-7.0, -5.0, 3.0], "Y", 0.5, 10.0) - cylinder([7.0, -5.0, 3.0], "Y", 0.5, 10.0)
