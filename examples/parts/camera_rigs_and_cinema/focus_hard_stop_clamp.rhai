// Follow focus hard stop: split ring clamp for an 0.8 module gear ring (73.6 mm over the teeth), 6 mm wide 5 mm thick band with a 2 mm gap, 12 x 10 mm clamping lugs with an M3 screw hole (3.2 mm) across them, and a 6 x 6 mm stop dog 8 mm tall on the outside
let ring_d = 73.6; // [50.0, 110.0] Gear ring diameter (mm)
let band_w = 6.0; // [4.0, 10.0] Band width (mm)
let dog_h = 8.0; // [4.0, 12.0] Stop dog height (mm)
const t = 5.0;
let ri = ring_d / 2.0;
let ro = ri + t;
let band = cylinder([0, 0, 0], "Z", ro, band_w) - cylinder([0, 0, -1.0], "Z", ri, band_w + 2.0);
let lugs = box_from_corners([-6.0, ri + 0.5, 0], [6.0, ro + 10.0, band_w]);
let gap = box_from_corners([-1.0, ri - 1.0, -1.0], [1.0, ro + 11.0, band_w + 1.0]);
let screw = cylinder([-7.0, ro + 5.0, band_w / 2.0], "X", 1.6, 14.0);
let dog = box_from_corners([-3.0, -ro - dog_h, 0], [3.0, -ro + 0.5, band_w]);
band + lugs + dog - gap - screw
