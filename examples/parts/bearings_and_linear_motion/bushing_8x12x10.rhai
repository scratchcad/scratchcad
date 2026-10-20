// Oil-less sintered bronze bushing 8 x 12 x 10 mm with chamfered ends and a lubrication groove
let bore = 8.0; // [3.0, 30.0] Bore (mm)
let outer = 12.0; // [5.0, 40.0] Outside diameter (mm)
let length = 10.0; // [4.0, 40.0] Length (mm)
let tube = cylinder(outer / 2.0, length) - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0);
tube = tube.chamfer(0.4, "%CIRCLE");
tube - (cylinder([0, 0, length / 2.0 - 0.4], "Z", bore / 2.0 + 0.3, 0.8))
