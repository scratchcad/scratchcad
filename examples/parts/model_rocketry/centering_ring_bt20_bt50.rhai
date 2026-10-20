// Centering ring BT-20 motor tube (18.7 mm OD) to BT-50 body (24.1 mm ID): 3 mm thick, engine hook notch
let inner = 18.7; // [13.0, 22.0] Motor tube OD (mm)
let outer = 24.1; // [24.0, 66.0] Body tube ID (mm)
let t = 3.0; // [1.5, 6.0] Thickness (mm)
let ring = cylinder(outer / 2.0, t) - cylinder([0, 0, -1], "Z", inner / 2.0, t + 2.0);
ring - box_from_corners([inner / 2.0 - 0.5, -1.5, -1], [inner / 2.0 + 1.2, 1.5, t + 1.0])
