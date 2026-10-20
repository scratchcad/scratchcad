// Laptop stand hinge block: 40 x 20 x 15 mm with 6 mm pin, 5 detent notches at 15 degree steps
let length = 40.0; // [30.0, 60.0] Length (mm)
let width = 20.0; // [15.0, 30.0] Width (mm)
let height = 15.0; // [10.0, 25.0] Height (mm)
let pin = 6.0; // [4.0, 8.0] Pin diameter (mm)
let block = box_from_corners([0, 0, 0], [length, width, height]);
let knuckle = cylinder([length, 0, height / 2.0], "Y", height / 2.0, width);
let notches = [];
for k in 0..5 { notches.push(box_centered(2.0, width + 2.0, 3.0).translate([0, 0, height / 2.0]).rotate([0, 0, 0], "Y", k.to_float() * 15.0 + 30.0).translate([length, width / 2.0, height / 2.0])); }
block + knuckle - cylinder([length, -1, height / 2.0], "Y", pin / 2.0, width + 2.0) - fuse_all(notches)
