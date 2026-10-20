// Awning keder rail stopper for 7 mm keder: 30 mm block that slides into a 7.5 mm channel with a 3.5 mm neck, M6 lock screw boss
let keder = 7.0; // [5.0, 12.0] Keder bead diameter (mm)
let length = 30.0; // [20.0, 45.0] Stopper length (mm)
let bead = cylinder([0, 0, 0], "Y", keder / 2.0 + 0.2, length);
let neck = box_from_corners([-1.6, 0, keder / 2.0 - 0.5], [1.6, length, keder / 2.0 + 4.0]);
let head = box_from_corners([-8.0, 0, keder / 2.0 + 3.99], [8.0, length, keder / 2.0 + 12.0]);
bead + neck + head - cylinder([0, length / 2.0, keder / 2.0 + 5.0], "Z", 2.5, 10.0)
