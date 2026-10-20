// Trophy column riser: 25 mm square column 120 mm tall with 1 mm chamfered edges, a 6 mm fluting groove on each face and a 5.5 mm M5 rod bore through the centre
let height = 120.0; // [60.0, 250.0] Column height (mm)
let size = 25.0; // [18.0, 35.0] Column size (mm)
let c = box_centered(size, size, height).translate([0, 0, height / 2.0]);
let c = c.chamfer(1.0, c.edges("|Z"));
let flutes = [];
for i in 0..4 { flutes.push(cylinder([size / 2.0 + 1.5, 0, 10.0], "Z", 3.0, height - 20.0).rotate_z(i.to_float() * 90.0)); }
c - fuse_all(flutes) - cylinder([0, 0, -1.0], "Z", 2.75, height + 2.0)
