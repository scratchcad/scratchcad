// Bottle cage adapter plate: 90 x 22 x 5 mm with two counterbored M5 slots 14 mm long on 64 mm centres
let pitch = 64.0; // [60.0, 74.0] Boss spacing (mm)
let length = 90.0; // [80.0, 120.0] Plate length (mm)
let width = 22.0; // [18.0, 30.0] Plate width (mm)
let t = 5.0; // [4.0, 8.0] Plate thickness (mm)
let plate = box_centered(width, length, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(width / 2.0 - 0.5, plate.edges("|Z"));
let slots = [];
for s in [-1.0, 1.0] { slots.push(box_centered(5.5, 14.0, t * 3.0).translate([0, s * pitch / 2.0, 0]) + box_centered(9.5, 18.0, 3.0).translate([0, s * pitch / 2.0, t])); }
p - fuse_all(slots)
