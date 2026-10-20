// Snap-on lens cap for a Pi camera: 9 mm inside diameter, 8 mm tall, 1.2 mm wall, small grip tab
let inner_d = 9.0; // [6.0, 20.0] Inner diameter (mm)
let height = 8.0; // [4.0, 15.0] Height (mm)
let wall = 1.2; // [0.8, 2.5] Wall thickness (mm)
let cap = cylinder(inner_d / 2.0 + wall, height).shell(-wall, "<Z").fillet(0.5, ">Z");
cap + box_from_corners([-2.0, inner_d / 2.0, height - 1.5], [2.0, inner_d / 2.0 + wall + 3.0, height])
