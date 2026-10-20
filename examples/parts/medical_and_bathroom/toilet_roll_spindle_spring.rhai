// Spring-loaded toilet roll spindle, assembled: 22 mm outer tube 80 mm with an end cap, 18.5 mm inner tube 70 mm sliding inside, spring omitted, 140 mm extended
let length = 140.0; // [120.0, 170.0] Extended length (mm)
let outer_diameter = 22.0; // [18.0, 28.0] Outer tube diameter (mm)
let cap_diameter = 28.0; // [22.0, 36.0] End cap diameter (mm)
let ro = outer_diameter / 2.0;
let ri = ro - 1.2;
let rin = ri - 0.4;
let lo = length * 0.57;
let outer = cylinder([0, 0, 0], "X", ro, lo) - cylinder([2.0, 0, 0], "X", ri, lo);
outer += cylinder([-3.0, 0, 0], "X", cap_diameter / 2.0, 3.1).fillet(1.0, "<X");
let li = length - lo + 25.0;
let inner = cylinder([length - li, 0, 0], "X", rin, li) - cylinder([length - li - 1.0, 0, 0], "X", rin - 1.2, li - 1.0);
inner += cylinder([length - 0.1, 0, 0], "X", cap_diameter / 2.0, 3.0).fillet(1.0, ">X");
compound([outer, inner])
