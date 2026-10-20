// Soap dish 110 x 75 mm, 20 mm tall, 2 mm walls, rounded, with 7 drainage slots and raised ribs
let length = 110.0; // [70.0, 160.0] Length (mm)
let width = 75.0; // [50.0, 120.0] Width (mm)
let height = 20.0; // [10.0, 40.0] Height (mm)
let wall = 2.0; // [1.2, 3.2] Wall thickness (mm)
let slots = 7; // [0, 10] Drain slots
let dish = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(15.0, "|Z").fillet(4.0, "<Z");
dish = dish.shell(-wall, ">Z");
let cuts = [];
for i in 0..slots { cuts.push(box_centered(4.0, width * 0.55, wall * 3.0).translate([(i.to_float() - (slots - 1).to_float() / 2.0) * 10.0, 0, 0]).fillet(1.9, "|Z")); }
let ribs = [];
for i in 0..(slots + 1) { ribs.push(box_centered(2.0, width * 0.7, 3.0).translate([(i.to_float() - slots.to_float() / 2.0) * 10.0, 0, wall + 1.5 - 0.01])); }
let d = if slots > 0 { dish - fuse_all(cuts) } else { dish };
fuse_all([d] + ribs)
