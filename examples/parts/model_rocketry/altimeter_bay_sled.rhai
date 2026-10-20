// Altimeter bay sled for 38 mm coupler: 33 x 100 mm board 3 mm, two 6.5 mm threaded rod tubes, 25 mm battery strap slots
let width = 33.0; // [25.0, 70.0] Sled width (mm)
let length = 100.0; // [60.0, 200.0] Sled length (mm)
let t = 3.0; // [2.0, 5.0] Board thickness (mm)
let board = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, length, t]);
let tt = [];
for x in [-width / 2.0 + 4.0, width / 2.0 - 4.0] { tt.push(cylinder([x, 0, t + 3.24], "Y", 4.25, length) - cylinder([x, -1, t + 3.24], "Y", 3.3, length + 2.0)); }
let slots = box_from_corners([-12.5, 20.0, -1], [12.5, 23.0, t + 1.0]) + box_from_corners([-12.5, 45.0, -1], [12.5, 48.0, t + 1.0]);
board + fuse_all(tt) - slots
