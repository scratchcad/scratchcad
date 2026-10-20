// SEM pin stub: 12.7 mm (1/2 in) head 3.2 mm thick, 3.2 mm pin 8 mm long, 45 degree chamfered head edge
let head = 12.7; // [6.0, 32.0] Head diameter (mm)
let t = 3.2; // [2.0, 5.0] Head thickness (mm)
let pin = 3.2; // [3.0, 3.2] Pin diameter (mm)
let pin_l = 8.0; // [6.0, 10.0] Pin length (mm)
let h = cylinder(head / 2.0, t);
let hh = h.chamfer(0.5, h.edges("<Z"));
hh + cylinder([0, 0, -pin_l], "Z", pin / 2.0, pin_l + 0.01)
