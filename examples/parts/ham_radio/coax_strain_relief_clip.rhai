// RG-8X coax strain relief clip: 6.1 mm cable snap, 30 x 15 mm base 3 mm with an M4 hole
let cable = 6.1; // [4.0, 11.0] Cable OD (mm)
let length = 30.0; // [20.0, 40.0] Base length (mm)
let width = 15.0; // [10.0, 20.0] Base width (mm)
let t = 3.0; // [2.0, 4.0] Base thickness (mm)
let base = box_from_corners([0, 0, 0], [length, width, t]);
let clip = cylinder([length - cable / 2.0 - 4.0, 0, t + cable / 2.0], "Y", cable / 2.0 + 2.0, width) - cylinder([length - cable / 2.0 - 4.0, -1, t + cable / 2.0], "Y", cable / 2.0, width + 2.0) - box_from_corners([length - cable / 2.0 - 4.0 - cable * 0.35, -1, t + cable * 0.8], [length - cable / 2.0 - 4.0 + cable * 0.35, width + 1.0, t + cable + 3.0]);
base + clip - cylinder([7.0, width / 2.0, -1], "Z", 2.1, t + 2.0)
