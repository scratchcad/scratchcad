// Desk flag holder: 50 mm round base 12 mm with a 2 mm chamfer and a 4.5 mm flag pole socket 10 mm deep angled 10 degrees
let base = 50.0; // [35.0, 80.0] Base diameter (mm)
let pole = 4.5; // [3.0, 8.0] Flag pole diameter (mm)
const h = 12.0;
let b = cylinder([0, 0, 0], "Z", base / 2.0, h);
let b = b.chamfer(2.0, b.edges(">Z"));
let boss = cylinder([0, 0, 0], "Z", pole / 2.0 + 3.0, 10.0).rotate_x(10.0).translate([0, 0, h - 1.0]);
b + boss - cylinder([0, 0, 1.0], "Z", pole / 2.0 + 0.1, 20.0).rotate_x(10.0).translate([0, 0, h - 1.0])
