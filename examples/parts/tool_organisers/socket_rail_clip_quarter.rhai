// Socket rail clip for 1/4 inch drive: 16 x 18 mm clip that snaps on a 20 mm wide C-rail with 1.5 mm lips, and a 6.35 mm square post 8 mm tall with a 1 mm detent ball bump
let rail = 20.0; // [16.0, 26.0] Rail width (mm)
let drive = 6.35; // [6.35, 12.7] Drive square (mm)
const t = 2.0;
let body = box_from_corners([-rail / 2.0 + 0.5, -8.0, 0], [rail / 2.0 - 0.5, 8.0, t + 4.0]);
let hooks = box_from_corners([-rail / 2.0 - 1.0, -8.0, 0], [-rail / 2.0 + 0.51, 8.0, 1.2]) + box_from_corners([rail / 2.0 - 0.51, -8.0, 0], [rail / 2.0 + 1.0, 8.0, 1.2]);
let post = box_centered(drive - 0.2, drive - 0.2, 8.0).translate([0, 0, t + 4.0 + 4.0 - 0.01]);
let bump = sphere([drive / 2.0 - 0.1, 0, t + 4.0 + 5.0], 1.0);
(body - box_from_corners([-rail / 2.0 + 3.0, -9.0, -1.0], [rail / 2.0 - 3.0, 9.0, 2.0])) + hooks + post + bump
