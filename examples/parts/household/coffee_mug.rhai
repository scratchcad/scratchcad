// Coffee mug: 82 mm diameter, 95 mm tall, 4 mm walls, 6 mm base, C-shaped handle 12 mm thick
let diameter = 82.0; // [60.0, 110.0] Outside diameter (mm)
let height = 95.0; // [60.0, 140.0] Height (mm)
let wall = 4.0; // [2.8, 8.0] Wall thickness (mm)
let base = 6.0; // [3.0, 12.0] Base thickness (mm)
let r = diameter / 2.0;
let body = cylinder(r, height).fillet(3.0, "<Z");
body = body - cylinder([0, 0, base], "Z", r - wall, height);
let path = wire([arc([r - 2.0, 0, height * 0.8], [r + 28.0, 0, height * 0.5], [r - 2.0, 0, height * 0.2])]);
let handle = rect(plane([r - 2.0, 0, height * 0.8], [1, 0, 0.6]), 10.0, 12.0).to_face().sweep(path);
(body + (handle - cylinder([0, 0, base], "Z", r - wall, height))).fillet(1.0, ">Z")
