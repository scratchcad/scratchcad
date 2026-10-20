// Toolmaker's parallel clamp jaw: 100 x 16 x 16 mm bar with a 45 degree nose bevel, an M8 tapped hole (6.8 mm) 30 mm from the nose and an 8.5 mm clearance hole 70 mm from it
let length = 100.0; // [70.0, 150.0] Jaw length (mm)
let s = 16.0; // [12.0, 22.0] Jaw section (mm)
let j = box_from_corners([0, 0, 0], [length, s, s]);
let bevel = face(polygon([[-1.0, -1.0, s + 0.01], [s * 0.6, -1.0, s + 0.01], [-1.0, -1.0, s * 0.4]])).extrude([0, s + 2.0, 0]);
j - bevel - cylinder([30.0, s / 2.0, -1.0], "Z", 3.4, s + 2.0) - cylinder([70.0, s / 2.0, -1.0], "Z", 4.25, s + 2.0)
