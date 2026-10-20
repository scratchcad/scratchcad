// Small-pet water bottle holder: 65 mm ring 10 mm tall for a 60 mm bottle with 2 mm walls, on a 40 x 30 mm hook plate with two 2.5 mm hooks for 2 mm cage wire spaced 12 mm
let bottle = 60.0; // [45.0, 80.0] Bottle diameter (mm)
let wire_gap = 12.0; // [8.0, 20.0] Cage wire spacing (mm)
const wall = 2.0;
let r = bottle / 2.0 + 0.5;
let ring = cylinder([0, 0, 0], "Z", r + wall, 10.0) - cylinder([0, 0, -1.0], "Z", r, 12.0);
let plate = box_from_corners([-20.0, r + wall - 1.0, 0], [20.0, r + wall + 2.0, 30.0]);
let hooks = [];
for x in [-wire_gap / 2.0, wire_gap / 2.0] { hooks.push(box_from_corners([x - 1.5, r + wall + 1.99, 22.0], [x + 1.5, r + wall + 5.0, 30.0]) + box_from_corners([x - 1.5, r + wall + 2.0, 18.0], [x + 1.5, r + wall + 5.0, 21.0]).translate([0, 0, 0])); }
ring + plate + fuse_all(hooks) - box_from_corners([-wire_gap, r + wall + 2.0, 21.0], [wire_gap, r + wall + 3.0, 22.01])
