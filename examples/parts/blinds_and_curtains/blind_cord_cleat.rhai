// Blind cord cleat: 70 mm two-horn cleat, 12 mm high, 2 x 4 mm countersunk screw holes 40 mm apart
let length = 70.0; // [50.0, 100.0] Cleat length (mm)
let height = 12.0; // [8.0, 20.0] Horn height (mm)
let base = box_from_corners([-12.0, -5.0, 0], [12.0, 5.0, 4.0]);
let b = base.fillet(3.0, base.edges("|Z"));
let horns = polygon([[-length / 2.0, height], [length / 2.0, height], [length / 2.0 - 4.0, height - 4.0], [6.0, height - 5.0], [4.0, 3.9], [-4.0, 3.9], [-6.0, height - 5.0], [-length / 2.0 + 4.0, height - 4.0]]).to_face().extrude([0, 0, 8.0]).rotate_x(90.0).translate([0, 4.0, 0]);
let holes = cylinder([-8.0, 0, -1], "Z", 2.0, 6.0) + cylinder([8.0, 0, -1], "Z", 2.0, 6.0);
b + horns - holes
