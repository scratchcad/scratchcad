// Chef knife blade guard: 210 x 50 mm sleeve for a 200 mm blade, 2.5 mm slot, 1.5 mm walls, finger notch
let length = 210.0; // [120.0, 280.0] Guard length (mm)
let height = 50.0; // [30.0, 65.0] Guard height (mm)
let slot = 2.5; // [1.5, 4.0] Blade slot (mm)
let wall = 1.5; // [1.0, 2.5] Wall (mm)
let outer = box_from_corners([0, -slot / 2.0 - wall, 0], [length, slot / 2.0 + wall, height]);
let o = outer.fillet(slot / 2.0 + wall - 0.1, outer.edges("|Y and >X"));
let inner = box_from_corners([-1, -slot / 2.0, wall], [length - wall, slot / 2.0, height + 1.0]);
o - inner - cylinder([20.0, -10.0, height], "Y", 10.0, 20.0)
