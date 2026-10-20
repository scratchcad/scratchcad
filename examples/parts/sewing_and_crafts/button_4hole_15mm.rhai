// Shirt button, 15 mm (24 ligne): 4 holes of 1.8 mm on a 4 mm square, dished face, 2.5 mm thick
let diameter = 15.0; // [10.0, 30.0] Diameter (mm)
let thickness = 2.5; // [1.5, 4.0] Thickness (mm)
let hole_d = 1.8; // [1.0, 3.0] Hole diameter (mm)
let spacing = 4.0; // [2.5, 8.0] Hole spacing (mm)
let blank = cylinder(diameter / 2.0, thickness);
let dish = sphere([0, 0, thickness + 30.0 - 0.6], 30.0);
let rim = blank - dish;
let holes = [];
for p in [[1, 1], [1, -1], [-1, 1], [-1, -1]] { holes.push(cylinder([p[0].to_float() * spacing / 2.0, p[1].to_float() * spacing / 2.0, -1], "Z", hole_d / 2.0, thickness + 2.0)); }
let b = rim - compound(holes);
b.fillet(0.5, b.edges("%CIRCLE").filter(|e| e.radius() > diameter / 2.0 - 0.01))
