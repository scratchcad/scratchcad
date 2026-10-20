// Lens wipe dispenser box: 80 x 60 x 50 mm box with 2 mm walls, a 40 x 6 mm pull slot in the lid, rounded 4 mm vertical corners and a 70 x 50 mm open base for refills
let width = 80.0; // [60.0, 120.0] Box width (mm)
let height = 50.0; // [30.0, 80.0] Box height (mm)
const depth = 60.0;
const wall = 2.0;
let b = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let b = b.fillet(4.0, b.edges("|Z"));
let inner = box_centered(width - 2.0 * wall, depth - 2.0 * wall, height).translate([0, 0, height / 2.0 - wall]);
let slot = box_centered(40.0, 6.0, wall + 2.0).translate([0, 0, height - wall / 2.0]);
b - inner - slot
