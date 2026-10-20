// Finger extensor trainer base: 70 x 30 mm palm plate 5 mm with 5 band pegs 6 mm tall in a row along one edge for loop bands, each with a 7 mm retaining cap
let width = 70.0; // [55.0, 90.0] Plate width (mm)
let pegs = 5; // [3, 6] Number of band pegs
const t = 5.0;
let p = box_centered(width, 30.0, t).translate([0, 0, t / 2.0]);
let p = p.fillet(8.0, p.edges("|Z"));
let ps = [];
for i in 0..pegs { let x = -width / 2.0 + 8.0 + (width - 16.0) * i.to_float() / (pegs - 1).to_float(); ps.push(cylinder([x, 8.0, t - 0.01], "Z", 2.5, 6.0) + cylinder([x, 8.0, t + 5.0], "Z", 3.5, 1.5)); }
p + fuse_all(ps)
