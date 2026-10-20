// F623ZZ flanged bearing: 3 x 10 x 4 mm with an 11.5 mm x 1 mm flange
let bore = 3.0; // [2.0, 8.0] Bore (mm)
let outer = 10.0; // [6.0, 22.0] Outside diameter (mm)
let width = 4.0; // [2.5, 7.0] Width (mm)
let flange_d = 11.5; // [7.5, 25.0] Flange diameter (mm)
let flange_t = 1.0; // [0.5, 1.5] Flange thickness (mm)
let body = cylinder(outer / 2.0, width) + cylinder([0, 0, width - flange_t], "Z", flange_d / 2.0, flange_t);
let gap = cylinder([0, 0, -1], "Z", outer / 2.0 - 1.0, width + 2.0) - cylinder([0, 0, -2], "Z", bore / 2.0 + 1.0, width + 4.0);
let recess = gap & (box_centered(outer, outer, 0.4).translate([0, 0, 0.2]) + box_centered(outer, outer, 0.4).translate([0, 0, width - 0.2]));
(body - cylinder([0, 0, -1], "Z", bore / 2.0, width + 2.0)) - recess
