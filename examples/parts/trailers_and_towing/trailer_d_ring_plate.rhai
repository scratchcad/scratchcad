// Trailer tie-down D-ring anchor plate: 80 x 60 x 5 mm plate with four 8.5 mm bolt holes on 60 x 40 mm centres and a 12 mm bar D-ring 50 mm wide, 30 mm tall
let ring_w = 50.0; // [35.0, 70.0] Ring inner width (mm)
let ring_h = 30.0; // [20.0, 45.0] Ring height (mm)
let bar = 12.0; // [8.0, 16.0] Ring bar diameter (mm)
const t = 5.0;
let plate = box_centered(80.0, 60.0, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(6.0, plate.edges("|Z"));
let legs = cylinder([-ring_w / 2.0 - bar / 2.0, 0, t - 0.01], "Z", bar / 2.0, ring_h - bar / 2.0) + cylinder([ring_w / 2.0 + bar / 2.0, 0, t - 0.01], "Z", bar / 2.0, ring_h - bar / 2.0);
let top = cylinder([-ring_w / 2.0 - bar / 2.0, 0, t + ring_h - bar / 2.0], "X", bar / 2.0, ring_w + bar);
let knuckles = sphere([-ring_w / 2.0 - bar / 2.0, 0, t + ring_h - bar / 2.0], bar / 2.0 + 0.2) + sphere([ring_w / 2.0 + bar / 2.0, 0, t + ring_h - bar / 2.0], bar / 2.0 + 0.2);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 30.0, sy * 20.0, -1.0], "Z", 4.25, t + 2.0)); } }
plate + legs + top + knuckles - fuse_all(holes)
