// Monitor riser foot: 60 x 60 mm, 80 mm tall, 18 mm shelf slot 40 mm deep, rubber pad recess
let size = 60.0; // [40.0, 80.0] Foot size (mm)
let height = 80.0; // [40.0, 120.0] Height (mm)
let shelf = 18.0; // [12.0, 25.0] Shelf thickness (mm)
let foot = box_centered(size, size, height).translate([0, 0, height / 2.0]);
let f = foot.fillet(5.0, foot.edges("|Z"));
let slot = box_from_corners([-size, -size, height - shelf], [-size / 2.0 + 40.0, size, height + 1.0]);
let pad = cylinder([0, 0, -1], "Z", 20.0, 2.0);
f - slot - pad
