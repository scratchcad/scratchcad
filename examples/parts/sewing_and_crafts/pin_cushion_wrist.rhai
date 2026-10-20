// Wrist pin cushion base: 70 mm dish 15 mm tall with 2 strap slots 25 x 3 mm
let diameter = 70.0; // [50.0, 100.0] Base diameter (mm)
let height = 15.0; // [8.0, 25.0] Dish height (mm)
let wall = 2.0; // [1.2, 3.0] Wall (mm)
let slot_w = 25.0; // [15.0, 40.0] Strap width (mm)
let dish = cylinder(diameter / 2.0, height);
let d = dish.shell(-wall, ">Z");
let slots = box_from_corners([-slot_w / 2.0, -diameter / 2.0 + 6.0, -1], [slot_w / 2.0, -diameter / 2.0 + 9.0, wall + 1.0]) + box_from_corners([-slot_w / 2.0, diameter / 2.0 - 9.0, -1], [slot_w / 2.0, diameter / 2.0 - 6.0, wall + 1.0]);
d - slots
