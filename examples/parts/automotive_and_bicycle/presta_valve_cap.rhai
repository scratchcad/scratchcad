// Presta valve dust cap: 7 mm OD, 10 mm long, 5.2 mm bore 8 mm deep, 12 grip flutes, rounded closed end
let len = 10.0; // [8.0, 14.0] Length (mm)
let cap = cylinder(3.5, len).fillet(0.6, "<Z") - cylinder([0, 0, 2.0], "Z", 2.6, len);
for i in 0..12 { cap -= cylinder([3.7, 0, -1], "Z", 0.45, len + 2.0).rotate("Z", i.to_float() * 30.0); }
cap
