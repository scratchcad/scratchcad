// Dosette box compartment lid: 24 x 22 x 1.5 mm flip lid with a 1 mm thick, 1.5 mm deep locating skirt inset 1.5 mm underneath, two 4 mm hinge knuckles 6 mm long on the back edge with a 1.6 mm pin bore and a gap between them for the box's knuckle, and a 6 x 3 mm rounded finger tab at the front
let lid_w = 24.0; // [18.0, 34.0] Lid width (mm)
let lid_d = 22.0; // [16.0, 30.0] Lid depth (mm)
let lid_t = 1.5; // [1.0, 2.5] Lid thickness (mm)
let knuckle_d = 4.0; // [3.0, 5.0] Knuckle diameter (mm)
let pin_d = 1.6; // [1.0, 2.0] Pin diameter (mm)
const knuckle_len = 6.0;
const skirt_t = 1.0;
const skirt_h = 1.5;
const inset = 1.5;
let kr = knuckle_d / 2.0;
let plate = box_from_corners([0, 0, 0], [lid_w, lid_d, lid_t]);
let tab = box_from_corners([lid_w / 2.0 - 3.0, -3.0, 0], [lid_w / 2.0 + 3.0, 0.5, lid_t]);
let tab = tab.fillet(1.2, tab.edges("|Z and <Y"));
let sy1 = lid_d - inset - kr;
let skirt = box_from_corners([inset, inset, -skirt_h], [lid_w - inset, sy1, 0.3])
    - box_from_corners([inset + skirt_t, inset + skirt_t, -skirt_h - 1.0], [lid_w - inset - skirt_t, sy1 - skirt_t, 1.0]);
let k1 = cylinder([0, lid_d, lid_t / 2.0], "X", kr, knuckle_len);
let k2 = cylinder([lid_w - knuckle_len, lid_d, lid_t / 2.0], "X", kr, knuckle_len);
let lid = fuse_all([plate, tab, skirt, k1, k2]);
lid - cylinder([-1.0, lid_d, lid_t / 2.0], "X", pin_d / 2.0, lid_w + 2.0)
