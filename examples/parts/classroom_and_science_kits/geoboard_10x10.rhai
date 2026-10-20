// Geoboard: 230 x 230 x 8 mm board with an 11 x 11 grid of 6 mm pegs 15 mm tall on 20 mm pitch
let n = 11; // [5, 15] Pegs per side
let pitch = 20.0; // [15.0, 30.0] Peg pitch (mm)
let t = 8.0; // [5.0, 12.0] Board thickness (mm)
let size = (n - 1).to_float() * pitch + 30.0;
let board = box_from_corners([0, 0, 0], [size, size, t]);
let b = board.fillet(5.0, board.edges("|Z"));
let pegs = [];
for i in 0..n { for j in 0..n { pegs.push(cylinder([15.0 + i.to_float() * pitch, 15.0 + j.to_float() * pitch, t - 0.01], "Z", 3.0, 15.0) + cylinder([15.0 + i.to_float() * pitch, 15.0 + j.to_float() * pitch, t + 13.0], "Z", 3.8, 2.0)); } }
b + compound(pegs)
