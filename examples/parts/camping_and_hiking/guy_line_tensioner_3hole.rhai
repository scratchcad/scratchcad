// Guyline tensioner, 3-hole aluminium style: 38 x 12 x 3 mm, three 4.5 mm holes for 3 mm cord
let length = 38.0; // [25.0, 60.0] Length (mm)
let width = 12.0; // [8.0, 20.0] Width (mm)
let thickness = 3.0; // [2.0, 5.0] Thickness (mm)
let hole_d = 4.5; // [3.0, 7.0] Hole diameter (mm)
let plate = box_centered(length, width, thickness);
let p = plate.fillet(width / 2.0 - 0.01, plate.edges("|Z"));
let holes = [];
for k in [-1.0, 0.0, 1.0] { holes.push(cylinder([k * (length / 2.0 - width / 2.0), 0, -thickness], "Z", hole_d / 2.0, thickness * 2.0)); }
p - compound(holes)
