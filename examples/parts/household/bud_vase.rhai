// Bud vase: lofted through a 50 mm base, 70 mm belly and 20 mm neck, 180 mm tall, 2 mm walls
let base_d = 50.0; // [30.0, 100.0] Base diameter (mm)
let belly_d = 70.0; // [40.0, 150.0] Belly diameter (mm)
let neck_d = 20.0; // [10.0, 60.0] Neck diameter (mm)
let height = 180.0; // [80.0, 400.0] Height (mm)
let wall = 2.0; // [1.0, 5.0] Wall thickness (mm)
let sections = [circle(base_d / 2.0), circle([0, 0, height * 0.3], "Z", belly_d / 2.0), circle([0, 0, height * 0.75], "Z", neck_d / 2.0), circle([0, 0, height], "Z", neck_d / 2.0 + 4.0)];
loft(sections, true).shell(-wall, ">Z")
