// GoPro-style two-prong mount: 2 prongs 3 mm thick 3.1 mm gap, 15 mm tall with a 5 mm bolt hole, 20 x 20 mm base 3 mm
let gap = 3.1; // [3.0, 3.3] Gap between prongs (mm)
let prong_t = 3.0; // [2.8, 3.2] Prong thickness (mm)
let height = 15.0; // [12.0, 20.0] Prong height to the hole (mm)
let base = box_centered(20.0, 20.0, 3.0).translate([0, 0, 1.5]);
let prongs = [];
for s in [-1.0, 1.0] {
    let x0 = s * (gap / 2.0 + prong_t / 2.0);
    prongs.push(box_centered(prong_t, 15.0, height).translate([x0, 0, height / 2.0 + 2.99]) + cylinder([x0 - prong_t / 2.0, 0, height + 3.0], "X", 7.5, prong_t));
}
base + fuse_all(prongs) - cylinder([-15.0, 0, height + 3.0], "X", 2.6, 30.0)
