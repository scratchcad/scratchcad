// Hasp staple: 50 x 30 x 3 mm plate with four 4.5 mm screw holes and a 6 mm round-bar staple loop 22 mm wide standing 18 mm proud for a padlock shackle
let width = 22.0; // [16.0, 30.0] Loop inner width (mm)
let proud = 18.0; // [12.0, 25.0] Loop height (mm)
const bar = 6.0;
const t = 3.0;
let plate = box_centered(50.0, 30.0, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(4.0, plate.edges("|Z"));
let legs = cylinder([-width / 2.0 - bar / 2.0, 0, t - 0.01], "Z", bar / 2.0, proud - bar / 2.0) + cylinder([width / 2.0 + bar / 2.0, 0, t - 0.01], "Z", bar / 2.0, proud - bar / 2.0);
let top = cylinder([-width / 2.0 - bar / 2.0, 0, t + proud - bar / 2.0 - 0.01], "X", bar / 2.0, width + bar) + sphere([-width / 2.0 - bar / 2.0, 0, t + proud - bar / 2.0 - 0.01], bar / 2.0 + 0.2) + sphere([width / 2.0 + bar / 2.0, 0, t + proud - bar / 2.0 - 0.01], bar / 2.0 + 0.2);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 20.0, sy * 10.0, -1.0], "Z", 2.25, t + 2.0)); } }
plate + legs + top - fuse_all(holes)
