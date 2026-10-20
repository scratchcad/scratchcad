// Towel ring: 50 mm wall rosette 14 mm deep, 40 mm drop arm 12 mm wide, 160 mm flat ring 8 x 8 mm, keyhole mount on the back
let ring_d = 160.0; // [120.0, 220.0] Ring outside diameter (mm)
let ring_w = 8.0; // [6.0, 12.0] Ring bar width (mm)
let drop = 40.0; // [20.0, 70.0] Arm drop (mm)
let rosette_d = 50.0; // [40.0, 70.0] Rosette diameter (mm)
let ro = ring_d / 2.0;
let zc = -drop - ro;
let ring = cylinder([0, 2.0, zc], "Y", ro, ring_w) - cylinder([0, 1.0, zc], "Y", ro - ring_w, ring_w + 2.0);
let arm = box_from_corners([-6.0, 2.0, -drop - ring_w / 2.0], [6.0, 2.0 + ring_w, 0]);
let rosette = cylinder([0, 0, 0], "Y", rosette_d / 2.0, 14.0);
let r = rosette.chamfer(2.0, rosette.edges(">Y"));
let keyhole = cylinder([0, -1, 6.0], "Y", 4.5, 7.0) + box_from_corners([-2.0, -1, -6.0], [2.0, 6.0, 6.0]) + cylinder([0, -1, -6.0], "Y", 2.0, 7.0);
r + arm + ring - keyhole
