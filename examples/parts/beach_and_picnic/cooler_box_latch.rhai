// Cool box lid latch: 50 x 20 mm lever latch 4 mm thick with a 9 mm pivot boss bored 4 mm, a 6 mm hook lip and a 15 mm thumb press pad
let length = 50.0; // [35.0, 70.0] Latch length (mm)
let hook = 6.0; // [4.0, 10.0] Hook lip depth (mm)
const t = 4.0;
let l = box_from_corners([0, -10.0, 0], [length, 10.0, t]);
let l = l.fillet(5.0, l.edges("|Z and <X"));
let h = box_from_corners([length - 4.0, -10.0, -hook], [length, 10.0, t]);
let pad = box_from_corners([0, -10.0, t - 0.01], [15.0, 10.0, t + 2.0]);
let boss = cylinder([length * 0.55, -10.0, t / 2.0], "Y", 4.5, 20.0);
l + h + pad + boss - cylinder([length * 0.55, -11.0, t / 2.0], "Y", 2.0, 22.0)
