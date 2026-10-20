// LEGO-compatible 1 x 2 plate: 15.8 x 7.8 x 3.2 mm with two studs and a 3.2 mm bar underneath
let n = 2; // [1, 8] Studs long
let w = n.to_float() * 8.0 - 0.2;
let plate = box_from_corners([0, 0, 0], [w, 7.8, 3.2]) - box_from_corners([1.2, 1.2, -1], [w - 1.2, 6.6, 2.2]);
for i in 0..n { plate += cylinder([3.9 + i.to_float() * 8.0, 3.9, 3.19], "Z", 2.4, 1.71); }
for i in 1..n { plate += cylinder([i.to_float() * 8.0 - 0.1, 3.9, 0], "Z", 1.6, 2.3); }
plate
