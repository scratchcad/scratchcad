// Toaster carriage lever knob: 30 x 20 x 15 mm, slot 9 x 2.2 mm for the lever blade, rounded paddle
let length = 30.0; // [20.0, 40.0] Length (mm)
let width = 20.0; // [12.0, 30.0] Width (mm)
let height = 15.0; // [10.0, 22.0] Height (mm)
let k = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let kk = k.fillet(5.0, k.edges("|Z"));
let top = kk.fillet(3.0, kk.edges(">Z"));
top - box_from_corners([-length / 2.0 - 1.0, -1.1, height / 2.0 - 4.5], [length / 2.0 - 8.0, 1.1, height / 2.0 + 4.5])
