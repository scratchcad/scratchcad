// Flanged bronze bushing 10 x 14 x 12 mm with an 18 mm x 2 mm flange
let bore = 10.0; // [4.0, 11.0] Bore (mm)
let outer = 14.0; // [12.0, 40.0] Outside diameter (mm)
let length = 12.0; // [5.0, 40.0] Length (mm)
let flange_d = 18.0; // [16.0, 50.0] Flange diameter (mm)
let flange_t = 2.0; // [1.0, 5.0] Flange thickness (mm)
let part = cylinder(outer / 2.0, length) + cylinder(flange_d / 2.0, flange_t);
(part - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0)).chamfer(0.3, "%CIRCLE and >Z")
