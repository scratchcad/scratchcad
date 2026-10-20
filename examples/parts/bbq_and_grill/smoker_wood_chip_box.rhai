// Smoker wood chip box: 230 x 95 x 40 mm, 1.2 mm wall, lid with 24 x 3 mm smoke slots and a split hinge barrel (two solids)
let length = 230.0; // [150.0, 300.0] Length (mm)
let width = 95.0; // [60.0, 130.0] Width (mm)
let height = 40.0; // [25.0, 60.0] Height (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let tray = box_from_corners([0, 0, 0], [length, width, height]) - box_from_corners([wall, wall, wall], [length - wall, width - wall, height + 1.0]);
let lid = box_from_corners([0, 0, height + 1.0], [length, width, height + 1.0 + wall]);
let slots = [];
for k in 0..24 { slots.push(box_from_corners([10.0 + k.to_float() * 8.8, 15.0, height], [13.0 + k.to_float() * 8.8, width - 15.0, height + 3.0])); }
let hinge = cylinder([-1.0, -2.0, height + 1.0], "X", 2.0, length + 2.0) - cylinder([-2.0, -2.0, height + 1.0], "X", 0.8, length + 4.0);
let h = (hinge + box_from_corners([0, -2.0, height - 1.0], [length, 0.01, height + 1.0 + wall])) - box_from_corners([-5, -5, height + 0.3], [length + 5.0, 5.0, height + 0.7]);
compound([tray + (h & box_from_corners([-5, -5, -1], [length + 5.0, 5.0, height + 0.3])), lid - compound(slots) + (h & box_from_corners([-5, -5, height + 0.7], [length + 5.0, 5.0, height + 10.0]))])
