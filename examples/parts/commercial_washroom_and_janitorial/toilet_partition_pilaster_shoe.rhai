// Toilet partition pilaster shoe: cover sleeve 80 mm tall for a 25 mm thick pilaster 150 mm wide, 1.5 mm wall with 1 mm chamfered vertical corners, and a 4 mm tall bead 1 mm proud around the top edge
let pilaster_t = 25.0; // [13.0, 40.0] Pilaster thickness (mm)
let pilaster_w = 150.0; // [80.0, 300.0] Pilaster width (mm)
let shoe_h = 80.0; // [50.0, 150.0] Shoe height (mm)
const wall = 1.5;
let iw = pilaster_w + 0.5;
let it = pilaster_t + 0.5;
let ow = iw + 2.0 * wall;
let ot = it + 2.0 * wall;
let outer = box_from_corners([-ow / 2.0, -ot / 2.0, 0], [ow / 2.0, ot / 2.0, shoe_h - 4.0]);
let outer = outer.chamfer(1.0, outer.edges("|Z"));
let bead = box_from_corners([-ow / 2.0 - 1.0, -ot / 2.0 - 1.0, shoe_h - 4.5], [ow / 2.0 + 1.0, ot / 2.0 + 1.0, shoe_h]);
let bead = bead.chamfer(1.5, bead.edges("|Z"));
let inner = box_from_corners([-iw / 2.0, -it / 2.0, -1.0], [iw / 2.0, it / 2.0, shoe_h + 1.0]);
(outer + bead) - inner
