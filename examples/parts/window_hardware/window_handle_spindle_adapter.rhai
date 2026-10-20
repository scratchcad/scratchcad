// Window handle spindle adapter: 7 mm square to 8 mm square sleeve, 30 mm long, slotted for a set screw
let inner = 7.0; // [6.0, 7.0] Spindle size (mm)
let outer = 8.0; // [8.0, 10.0] Handle socket size (mm)
let length = 30.0; // [20.0, 45.0] Length (mm)
let sl = box_centered(outer - 0.1, outer - 0.1, length).translate([0, 0, length / 2.0]);
sl - box_centered(inner + 0.15, inner + 0.15, length * 3.0) - box_centered(0.8, outer, length * 0.6).translate([0, outer / 2.0, length / 2.0])
