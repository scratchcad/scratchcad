// Acrylic award stand base: 120 x 50 x 20 mm block with a 6.2 mm slot 12 mm deep for a 6 mm acrylic plate, tilted back 8 degrees, and 1.5 mm chamfered top edges
let width = 120.0; // [80.0, 200.0] Base width (mm)
let plate_t = 6.2; // [3.2, 10.2] Plate slot width (mm)
const depth = 50.0;
const h = 20.0;
let b = box_centered(width, depth, h).translate([0, 0, h / 2.0]);
let b = b.chamfer(1.5, b.edges(">Z"));
let slot = box_centered(width - 20.0, plate_t, 30.0).rotate_x(-8.0).translate([0, 0, h]);
b - (slot & box_centered(width, depth, 2.0 * h).translate([0, 0, h - 12.0 + h]))
