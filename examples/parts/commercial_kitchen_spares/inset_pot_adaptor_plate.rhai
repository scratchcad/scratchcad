// Steam table inset adaptor plate: GN 1/1 size 530 x 325 mm, 1.5 mm stainless with 10 mm turned-down edges and a 254 mm hole with a 15 mm raised collar for an 11 qt round inset pot
let hole_d = 254.0; // [150.0, 290.0] Inset hole diameter (mm)
let collar = 15.0; // [5.0, 25.0] Collar height (mm)
let skirt = 10.0; // [6.0, 20.0] Edge skirt depth (mm)
const t = 1.5;
const len = 530.0;
const w = 325.0;
let plate = box_from_corners([-len / 2.0, -w / 2.0, -skirt], [len / 2.0, w / 2.0, 0]).shell(-t, "<Z");
let ring = cylinder([0, 0, -t / 2.0], "Z", hole_d / 2.0 + t, collar + t / 2.0);
(plate + ring) - cylinder([0, 0, -t - 1.0], "Z", hole_d / 2.0, collar + t + 2.0)
