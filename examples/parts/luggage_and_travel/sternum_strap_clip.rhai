// Backpack sternum strap rail clip: slides on a 15 mm shoulder strap rail of 4 mm tube, 20 x 12 mm C-clip 2.5 mm thick with a 20 mm webbing slot 3 mm wide on the outside
let webbing = 20.0; // [15.0, 25.0] Webbing width (mm)
let tube = 4.0; // [3.0, 6.0] Rail tube diameter (mm)
const t = 2.5;
let r = tube / 2.0 + 0.2;
let c = cylinder([0, -6.0, 0], "Y", r + t, 12.0) - cylinder([0, -7.0, 0], "Y", r, 14.0) - box_from_corners([-r * 0.7, -7.0, -r - t - 1.0], [r * 0.7, 7.0, 0]);
let body = box_from_corners([-webbing / 2.0 - 3.0, -6.0, r + t - 0.5], [webbing / 2.0 + 3.0, 6.0, r + t + 4.0]);
c + body - box_from_corners([-webbing / 2.0, -1.5, r + t - 1.0], [webbing / 2.0, 1.5, r + t + 5.0])
