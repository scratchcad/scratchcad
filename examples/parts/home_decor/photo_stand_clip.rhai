// Photo / card holder stand: 40 mm cube base, 120 mm 2 mm wire-style stem, spiral clip 15 mm
let base = 40.0; // [25.0, 60.0] Base cube size (mm)
let stem_h = 120.0; // [60.0, 200.0] Stem height (mm)
let stem_d = 3.0; // [2.0, 5.0] Stem diameter (mm)
let b = box_centered(base, base, base).translate([0, 0, base / 2.0]);
let bb = b.fillet(4.0, b.edges());
let stem = cylinder([0, 0, base - 2.0], "Z", stem_d / 2.0, stem_h + 2.0);
let clip = cylinder([0, -stem_d / 2.0, base + stem_h + 7.0], "Y", 8.0, stem_d) - cylinder([0, -stem_d, base + stem_h + 7.0], "Y", 5.0, stem_d * 2.0) - box_from_corners([-0.6, -5, base + stem_h + 7.0], [0.6, 5, base + stem_h + 20.0]);
bb + stem + clip
