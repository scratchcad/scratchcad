// Table menu clip stand: 50 mm round weighted base 15 mm, 60 mm stem 8 mm, alligator-style 25 mm clip jaws
let base = 50.0; // [35.0, 70.0] Base diameter (mm)
let stem_h = 60.0; // [30.0, 100.0] Stem height (mm)
let b = cylinder(base / 2.0, 15.0);
let bb = b.fillet(4.0, b.edges(">Z"));
let stem = cylinder([0, 0, 14.99], "Z", 4.0, stem_h);
let jaw = box_from_corners([-12.5, -4.0, 15.0 + stem_h - 0.01], [12.5, -0.5, 15.0 + stem_h + 12.0]) + box_from_corners([-12.5, 0.5, 15.0 + stem_h - 0.01], [12.5, 4.0, 15.0 + stem_h + 12.0]);
let bridge = box_from_corners([-12.5, -4.0, 15.0 + stem_h - 2.0], [12.5, 4.0, 15.0 + stem_h + 0.5]);
bb + stem + jaw + bridge
