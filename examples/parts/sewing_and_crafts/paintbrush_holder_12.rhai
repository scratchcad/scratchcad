// Paintbrush holder: 12 holes 10 mm on a 160 x 50 x 30 mm block, sloped 15 degrees, with a water channel
let length = 160.0; // [100.0, 250.0] Length (mm)
let depth = 50.0; // [35.0, 80.0] Depth (mm)
let height = 30.0; // [20.0, 50.0] Height (mm)
let hole_d = 10.0; // [6.0, 16.0] Hole diameter (mm)
let block = polygon([[0, 0, 0], [0, depth, 0], [0, depth, height], [0, 0, height - depth * 0.268]]).to_face().extrude([length, 0, 0]);
let holes = [];
for i in 0..6 { for j in 0..2 {
    holes.push(cylinder([12.0 + i.to_float() * (length - 24.0) / 5.0, 14.0 + j.to_float() * 20.0, 6.0], "Z", hole_d / 2.0 + j.to_float() * 1.0, height));
} }
block - compound(holes)
