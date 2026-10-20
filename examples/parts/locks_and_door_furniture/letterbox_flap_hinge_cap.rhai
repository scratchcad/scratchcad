// Letter plate flap hinge end cap: 12 mm dia 10 mm long cap with a 4 mm hinge pin bore 8 mm deep, joined to a 20 x 14 x 3 mm fixing tab with a 3.5 mm hole
let pin = 4.0; // [3.0, 6.0] Hinge pin diameter (mm)
let dia = 12.0; // [10.0, 16.0] Cap diameter (mm)
const length = 10.0;
let cap = cylinder([0, 0, 0], "Z", dia / 2.0, length);
let tab = box_from_corners([0, -1.5, 0], [20.0, 1.5, 14.0]);
cap + tab - cylinder([0, 0, length - 8.0], "Z", pin / 2.0 + 0.1, 9.0) - cylinder([14.0, -3.0, 7.0], "Y", 1.75, 6.0)
