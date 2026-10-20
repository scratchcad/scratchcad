// Balancing bird desk toy: 120 mm wingspan bird 4 mm thick from a straight-segment outline, beak balance point at the front, with two 10 mm weight pockets 3 mm deep in the wing tips
let span = 120.0; // [80.0, 180.0] Wingspan (mm)
let length = 70.0; // [50.0, 100.0] Body length (mm)
const t = 4.0;
let w = span / 2.0;
let outline = polygon([[0, 0, 0], [8.0, 6.0, 0], [w, length * 0.2, 0], [w - 4.0, length * 0.35, 0], [12.0, length * 0.45, 0], [6.0, length, 0], [-6.0, length, 0], [-12.0, length * 0.45, 0], [-w + 4.0, length * 0.35, 0], [-w, length * 0.2, 0], [-8.0, 6.0, 0]]);
let b = face(outline).extrude([0, 0, t]);
b - cylinder([w - 8.0, length * 0.25, t - 3.0], "Z", 5.0, 4.0) - cylinder([-w + 8.0, length * 0.25, t - 3.0], "Z", 5.0, 4.0)
