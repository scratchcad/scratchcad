// Gondola shelf product divider: 400 mm long, 75 mm tall, 2 mm fin on an 18 mm T-base with 3 snap pegs
let length = 400.0; // [200.0, 600.0] Length (mm)
let height = 75.0; // [40.0, 150.0] Height (mm)
let t = 2.0; // [1.5, 3.0] Fin thickness (mm)
let fin = polygon([[0, 0], [length, 0], [length, height * 0.4], [length - 30.0, height], [0, height]]).to_face().extrude([0, 0, t]).rotate_x(90.0).translate([0, t / 2.0, 0]);
let base = box_from_corners([0, -9.0, 0], [length, 9.0, 2.0]);
let pegs = [];
for x in [40.0, length / 2.0, length - 40.0] { pegs.push(cylinder([x, 0, -4.0], "Z", 2.5, 4.01) + sphere([x, 0, -4.0], 2.8) & cylinder([x, 0, -6.0], "Z", 3.0, 8.0)); }
fin + base + fuse_all(pegs)
