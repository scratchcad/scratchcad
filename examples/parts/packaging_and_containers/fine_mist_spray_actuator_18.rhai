// Fine-mist spray actuator for a 4 mm pump stem: 18 mm button 15 mm tall, dished finger pad, hollow skirt, 2.0 mm stem socket 7 mm deep, 1.2 mm swirl channel to a 4 mm insert pocket for the 0.25 mm orifice insert
let diameter = 18.0; // [14.0, 24.0] Actuator diameter (mm)
let height = 15.0; // [10.0, 20.0] Actuator height (mm)
let stem_socket = 4.0; // [3.0, 6.0] Stem socket diameter (mm)
let insert_pocket = 4.0; // [3.0, 6.0] Orifice insert pocket diameter (mm)
let r = diameter / 2.0;
let rs = stem_socket / 2.0;
let zc = height * 0.62;
let act = cylinder(r, height).fillet(1.0, ">Z");
// finger pad: shallow spherical dish
const dish_r = 30.0;
act = act - sphere([0, 0, height - 0.8 + dish_r], dish_r);
// hollow skirt with a central boss holding the stem socket
act = act - cylinder([0, 0, -1], "Z", r - 1.2, zc - 2.0 + 1.0);
act = act + (cylinder([0, 0, 1.0], "Z", rs + 1.2, zc - 2.0) - cylinder([0, 0, 0], "Z", rs, 1.5));
act = act - cylinder([0, 0, -1], "Z", rs, zc + 0.6);
// swirl channel from the socket to the front insert pocket at +X
act = act - cylinder([0, 0, zc], "X", 0.6, r - 2.0);
act - cylinder([r - 2.5, 0, zc], "X", insert_pocket / 2.0, 3.0)
