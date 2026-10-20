// Polyester strap wire-style buckle for 16 mm strap: 26 x 20 mm frame 4 mm round section, centre bar offset 4 mm
let strap = 16.0; // [12.0, 25.0] Strap width (mm)
let rod = 4.0; // [3.0, 5.5] Bar diameter (mm)
let w = strap + 2.0 * rod + 2.0;
let frame = box_centered(w, 20.0, rod) - box_centered(w - 2.0 * rod, 20.0 - 2.0 * rod, rod * 3.0);
let f = frame.fillet(rod / 2.0 - 0.1, frame.edges("|Z"));
let bar = box_centered(w - 2.0 * rod + 0.02, rod, rod).translate([0, 2.0, 0]);
f + bar
