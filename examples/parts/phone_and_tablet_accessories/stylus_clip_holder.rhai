// Stylus holder clip for a tablet case: 9 mm C-clip 20 mm long gripping the pencil, on a 25 x 20 mm adhesive pad 1.5 mm thick
let pencil = 9.0; // [7.0, 12.0] Stylus diameter (mm)
let length = 20.0; // [12.0, 30.0] Clip length (mm)
const wall = 1.6;
let pad = box_from_corners([-12.5, 0, 0], [12.5, length, 1.5]);
let ring = cylinder([0, 0, 1.5 + pencil / 2.0 - 0.5], "Y", pencil / 2.0 + wall, length) - cylinder([0, -1.0, 1.5 + pencil / 2.0 - 0.5], "Y", pencil / 2.0, length + 2.0);
let mouth = box_from_corners([-pencil * 0.35, -1.0, 1.5 + pencil * 0.75], [pencil * 0.35, length + 1.0, pencil + 5.0]);
pad + ring - mouth
