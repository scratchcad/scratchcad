// Bench fume extractor adapter: 130 mm fan square 3 mm flange to a 50 mm duct spigot, 105 mm hole pattern
let fan = 130.0; // [90.0, 150.0] Flange size (mm)
let duct = 50.0; // [32.0, 100.0] Duct OD (mm)
let length = 60.0; // [40.0, 100.0] Transition length (mm)
let wall = 2.0; // [1.5, 3.0] Wall (mm)
let flange = box_centered(fan, fan, 3.0).translate([0, 0, 1.5]);
let outer = loft([rect(plane([0, 0, 2.99], [0, 0, 1]), fan - 10.0, fan - 10.0), circle(plane([0, 0, length], [0, 0, 1]), duct / 2.0)], true) + cylinder([0, 0, length], "Z", duct / 2.0, 30.0);
let inner = loft([rect(plane([0, 0, -1.0], [0, 0, 1]), fan - 10.0 - 2.0 * wall, fan - 10.0 - 2.0 * wall), circle(plane([0, 0, length], [0, 0, 1]), duct / 2.0 - wall)], true) + cylinder([0, 0, length], "Z", duct / 2.0 - wall, 31.0);
let holes = [];
for sx in [-1.0, 1.0] { for sy in [-1.0, 1.0] { holes.push(cylinder([sx * 52.5, sy * 52.5, -1], "Z", 2.2, 5.0)); } }
flange + outer - inner - compound(holes)
