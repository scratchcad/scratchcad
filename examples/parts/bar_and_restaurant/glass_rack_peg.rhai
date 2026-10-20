// Dishwasher glass rack peg insert: 15 mm square base for a 500 mm rack grid, 60 mm tall 8 mm tapered peg
let base = 15.0; // [10.0, 20.0] Base square (mm)
let height = 60.0; // [40.0, 90.0] Peg height (mm)
let peg_d = 8.0; // [5.0, 12.0] Peg diameter at the base (mm)
let b = box_centered(base, base, 4.0).translate([0, 0, 2.0]);
let clips = box_centered(2.0, base - 4.0, 6.0).translate([base / 2.0 - 3.0, 0, -2.99]) + box_centered(2.0, base - 4.0, 6.0).translate([-base / 2.0 + 3.0, 0, -2.99]);
let peg = cone(peg_d / 2.0, peg_d / 4.0, height).translate([0, 0, 3.99]) + sphere([0, 0, height + 3.99], peg_d / 4.0);
b + clips + peg
