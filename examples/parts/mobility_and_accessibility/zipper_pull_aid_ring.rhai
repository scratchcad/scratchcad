// Zipper pull aid: 40 mm finger ring 4 mm thick with a 25 mm stem and an 8 x 2.5 mm hook slot that clips onto a zip slider tab; for users with limited finger dexterity
// # Ring
let ring_od = 40.0; // [30.0, 55.0] Ring outer diameter (mm)
let ring_width = 6.0; // [4.0, 10.0] Ring band width (mm)
let thickness = 4.0; // [3.0, 6.0] Thickness (mm)
// # Hook
let stem = 25.0; // [15.0, 40.0] Stem length (mm)
let slot_w = 2.5; // [1.5, 4.0] Hook slot width (mm)
let ro = ring_od / 2.0;
let ring = cylinder(ro, thickness) - cylinder([0, 0, -1], "Z", ro - ring_width, thickness + 2.0);
let stem_bar = box_from_corners([-5.0, ro - 2.0, 0], [5.0, ro + stem, thickness]).fillet(4.5, "|Z and >Y");
let slot = box_from_corners([-slot_w / 2.0, ro + stem - 12.0, -1.0], [slot_w / 2.0, ro + stem + 1.0, thickness + 1.0]);
let catch_hole = box_from_corners([-4.0, ro + stem - 14.0, -1.0], [4.0, ro + stem - 11.0, thickness + 1.0]);
(ring + stem_bar) - slot - catch_hole
