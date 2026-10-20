// Rope ladder rung end block: 42 mm cube (rung + 12 mm) with filleted vertical edges, with a 14 mm rope bore through vertically and a 30.5 mm rung socket 25 mm deep with a 6 mm pin hole
let rope = 14.0; // [10.0, 18.0] Rope diameter (mm)
let rung = 30.0; // [25.0, 40.0] Rung diameter (mm)
let s = rung + 12.0;
let b = box_centered(s, s, s).translate([0, 0, 0]);
let b = b.fillet(4.0, b.edges("|Z"));
b - cylinder([0, s / 2.0 - rope / 2.0 - 3.0, -s], "Z", rope / 2.0 + 0.5, 2.0 * s) - cylinder([-s / 2.0 - 1.0, -2.0, 0], "X", rung / 2.0 + 0.25, 26.0) - cylinder([-s / 2.0 + 12.0, -2.0, -s], "Z", 3.0, 2.0 * s)
