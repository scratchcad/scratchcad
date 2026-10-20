// Arris rail repair bracket: 2 mm galvanised-style V-bracket for a 75 mm triangular arris rail, 50 mm wide, two 60 mm wings at 90 degrees and a 40 mm post flange with 3 screw holes
let wing = 60.0; // [40.0, 80.0] Wing length (mm)
let width = 50.0; // [30.0, 70.0] Bracket width (mm)
const t = 2.0;
let a = box_from_corners([0, 0, 0], [wing, t, width]).rotate_z(-45.0);
let b = box_from_corners([0, -t, 0], [wing, 0, width]).rotate_z(45.0);
let flange = box_from_corners([-t, -40.0, 0], [0.01, 40.0, width]);
let v = a + b + flange;
let holes = [cylinder([-5.0, -30.0, width / 2.0], "X", 2.5, 10.0), cylinder([-5.0, 30.0, width / 2.0], "X", 2.5, 10.0), cylinder([-5.0, 0, width * 0.2], "X", 2.5, 10.0)];
v - fuse_all(holes)
