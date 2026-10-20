// Litter bin lid hinge knuckle: 60 x 30 x 4 mm leaf with two 6.5 mm bolt holes and a 16 mm knuckle 30 mm long bored 8.2 mm for an 8 mm hinge pin
let pin = 8.2; // [6.2, 12.2] Pin bore (mm)
let leaf_l = 60.0; // [40.0, 90.0] Leaf length (mm)
const t = 4.0;
let leaf = box_from_corners([0, 0, 0], [leaf_l, 30.0, t]);
let knuckle = cylinder([0, 0, pin / 2.0 + 2.5], "Y", pin / 2.0 + 4.0, 30.0) + box_from_corners([0, 0, 0], [pin / 2.0 + 4.0, 30.0, pin / 2.0 + 2.5]);
leaf + knuckle - cylinder([0, -1.0, pin / 2.0 + 2.5], "Y", pin / 2.0, 32.0) - cylinder([leaf_l * 0.45, 15.0, -1.0], "Z", 3.25, t + 2.0) - cylinder([leaf_l * 0.85, 15.0, -1.0], "Z", 3.25, t + 2.0)
