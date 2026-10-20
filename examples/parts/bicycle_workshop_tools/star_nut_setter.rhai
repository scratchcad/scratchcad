// Star nut setter for 1 1/8 in steerers: 36 mm striking head 25 mm tall with a 1.5 mm chamfer, 24.8 mm guide sleeve 15 mm long that centres in the steerer, 6 mm bore through for the M6 setting bolt
let head_d = 36.0; // [30.0, 45.0] Head diameter (mm)
let head_h = 25.0; // [15.0, 40.0] Head height (mm)
let guide_d = 24.8; // [21.0, 28.0] Guide diameter (mm)
let guide_len = 15.0; // [8.0, 25.0] Guide length (mm)
const bore = 6.0;
let head = cylinder([0, 0, guide_len], "Z", head_d / 2.0, head_h);
let head = head.chamfer(1.5, head.edges(">Z"));
let guide = cylinder([0, 0, 0], "Z", guide_d / 2.0, guide_len + 0.5);
let guide = guide.chamfer(1.0, guide.edges("<Z"));
(head + guide) - cylinder([0, 0, -1.0], "Z", bore / 2.0, guide_len + head_h + 2.0)
