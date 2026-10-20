// RC boat hatch twist latch: 30 x 8 x 3 mm turn-button with rounded ends on a 4 mm boss, 2 mm screw hole, and a 1 mm ramp on one side to pull the hatch down as it turns
let length = 30.0; // [20.0, 45.0] Latch length (mm)
let width = 8.0; // [6.0, 12.0] Latch width (mm)
const t = 3.0;
let bar = box_centered(length - width, width, t).translate([0, 0, t / 2.0]) + cylinder([-(length - width) / 2.0, 0, 0], "Z", width / 2.0, t) + cylinder([(length - width) / 2.0, 0, 0], "Z", width / 2.0, t);
let boss = cylinder([0, 0, -1.99], "Z", 4.0, 2.0);
let ramp = face(polygon([[length / 2.0 - 10.0, -width / 2.0, 0], [length / 2.0, -width / 2.0, 0], [length / 2.0, -width / 2.0, -1.0]])).extrude([0, width, 0]);
bar + boss - ramp - cylinder([0, 0, -3.0], "Z", 1.0, t + 4.0)
