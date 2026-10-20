// Cape clasp half: 40 mm round boss 6 mm thick with a raised 3 mm rim, a 12 x 4 mm chain loop on one side and two 3 mm sew-on holes (one half; print two)
let dia = 40.0; // [28.0, 60.0] Clasp diameter (mm)
let t = 6.0; // [4.0, 10.0] Clasp thickness (mm)
let c = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let rim = cylinder([0, 0, t - 0.01], "Z", dia / 2.0, 2.0) - cylinder([0, 0, t - 1.0], "Z", dia / 2.0 - 3.0, 4.0);
let loop_ = box_from_corners([dia / 2.0 - 2.0, -6.0, 0], [dia / 2.0 + 8.0, 6.0, 4.0]) - box_from_corners([dia / 2.0 + 2.0, -3.0, -1.0], [dia / 2.0 + 6.0, 3.0, 5.0]);
c + rim + loop_ - cylinder([-dia / 4.0, -dia / 6.0, -1.0], "Z", 1.5, t + 2.0) - cylinder([-dia / 4.0, dia / 6.0, -1.0], "Z", 1.5, t + 2.0)
