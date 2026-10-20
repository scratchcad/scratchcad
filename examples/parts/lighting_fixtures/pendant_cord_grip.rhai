// Pendant cord grip / strain relief: 10 mm cone gland, 6 mm cord hole, M10 x 1 stud 10 mm, 2 collet slits
let cord = 6.0; // [4.0, 9.0] Cord diameter (mm)
let stud = 10.0; // [8.0, 13.0] Stud diameter (mm)
let body = cylinder(stud / 2.0, 10.0) + cylinder([0, 0, 9.99], "Z", 7.5, 4.0) + cone(7.5, cord / 2.0 + 1.5, 12.0).translate([0, 0, 13.98]);
let slits = box_centered(1.0, 20.0, 9.0).translate([0, 0, 21.0]) + box_centered(20.0, 1.0, 9.0).translate([0, 0, 21.0]);
body - cylinder([0, 0, -1], "Z", cord / 2.0, 30.0) - slits
