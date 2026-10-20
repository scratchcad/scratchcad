// Climbing hold, jug: 120 x 80 mm footprint, 45 mm deep incut lip, 10 mm bolt hole with 22 mm counterbore and a set-screw hole
let w = 120.0; // [80.0, 200.0] Hold width (mm)
let base = loft([rect(plane([0, 0, 0], "Z"), w, 80.0), rect(plane([0, 5.0, 25.0], "Z"), w * 0.85, 60.0), rect(plane([0, -5.0, 45.0], "Z"), w * 0.7, 30.0)], true);
let hold = base - cylinder([-w, -32.0, 30.0], "X", 14.0, 2.0 * w);
hold - cylinder([0, 0, -1], "Z", 5.25, 60.0) - cylinder([0, 0, 25.0], "Z", 11.0, 30.0) - cylinder([w * 0.3, 10.0, -1], "Z", 2.5, 20.0)
