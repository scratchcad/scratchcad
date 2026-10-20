// Lino cutter handle: 105 mm mushroom-ended handle, 18 mm grip waisted to 14 mm, with an 8 mm collet nose 15 mm long and a 3.2 mm blade bore 20 mm deep slit 0.8 mm
let length = 105.0; // [80.0, 130.0] Handle length (mm)
let grip = 18.0; // [14.0, 24.0] Grip diameter (mm)
const nose = 8.0;
let body = loft([circle([0, 0, 15.0], [0, 0, 1], nose / 2.0 + 1.0), circle([0, 0, 35.0], [0, 0, 1], 7.0), circle([0, 0, length - 25.0], [0, 0, 1], grip / 2.0), circle([0, 0, length - 0.01], [0, 0, 1], grip / 2.0 - 1.0)], true);
let nose_c = cylinder([0, 0, 0], "Z", nose / 2.0, 15.01);
let cap = cylinder([0, 0, length - 0.02], "Z", grip / 2.0 + 2.0, 6.0);
let cap = cap.fillet(2.0, cap.edges(">Z"));
let bore = cylinder([0, 0, -1.0], "Z", 1.6, 21.0);
let slit = box_from_corners([-0.4, -nose, -1.0], [0.4, nose, 12.0]);
nose_c + body + cap - bore - slit
