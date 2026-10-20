// Spoke reflector holder: 70 x 30 mm oval plate 3 mm with a 25 x 15 mm reflector pocket, 2 spoke clips for 2 mm spokes
let length = 70.0; // [50.0, 90.0] Plate length (mm)
let width = 30.0; // [20.0, 40.0] Plate width (mm)
let t = 3.0; // [2.0, 4.0] Plate thickness (mm)
let spoke = 2.0; // [1.6, 2.6] Spoke diameter (mm)
let plate = box_centered(length, width, t).translate([0, 0, t / 2.0]);
let p = plate.fillet(width / 2.0 - 0.5, plate.edges("|Z"));
let clips = [];
for x in [-length / 2.0 + 10.0, length / 2.0 - 10.0] { clips.push(cylinder([x - 4.0, 0, -spoke / 2.0 - 0.5], "X", spoke / 2.0 + 1.5, 8.0) - cylinder([x - 5.0, 0, -spoke / 2.0 - 0.5], "X", spoke / 2.0, 10.0) - box_centered(10.0, spoke * 0.7, spoke).translate([x, 0, -spoke - 1.0])); }
p - box_centered(25.0, 15.0, 2.0).translate([0, 0, t]) + fuse_all(clips)
