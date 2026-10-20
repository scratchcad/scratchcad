// Prop sword crossguard: 180 mm guard 20 mm tall, 16 mm thick at the centre tapering to 10 mm, with 14 mm ball finials, with a 30 x 6 mm blade slot and a 22 mm round grip socket 10 mm deep underneath
let span = 180.0; // [120.0, 260.0] Guard span (mm)
let blade_w = 30.0; // [20.0, 45.0] Blade width (mm)
const h = 20.0;
let g = face(polygon([[-span / 2.0, -5.0, 0], [-25.0, -8.0, 0], [25.0, -8.0, 0], [span / 2.0, -5.0, 0], [span / 2.0, 5.0, 0], [25.0, 8.0, 0], [-25.0, 8.0, 0], [-span / 2.0, 5.0, 0]])).extrude([0, 0, h]);
let tips = sphere([-span / 2.0, 0, h / 2.0], 7.0) + sphere([span / 2.0, 0, h / 2.0], 7.0);
g + tips - box_centered(blade_w, 6.0, h + 2.0).translate([0, 0, h / 2.0]) - cylinder([0, 0, -1.0], "Z", 11.0, 11.0)
