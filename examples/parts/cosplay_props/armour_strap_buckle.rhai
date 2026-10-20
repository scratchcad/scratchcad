// Foam armour strap buckle: 40 x 30 mm buckle 3 mm thick for 25 mm elastic, with a 25 x 4 mm strap slot, a 15 mm prong hook and two 3 mm rivet holes for the foam side
let strap = 25.0; // [15.0, 40.0] Strap width (mm)
let t = 3.0; // [2.0, 5.0] Buckle thickness (mm)
let w = strap + 10.0;
let b = box_centered(w, 30.0, t).translate([0, 0, t / 2.0]);
let b = b.fillet(4.0, b.edges("|Z"));
let hook = box_from_corners([-4.0, 15.0 - 0.01, 0], [4.0, 30.0, t]) + box_from_corners([-4.0, 26.0, 0], [4.0, 30.0, t + 5.0]);
b + hook - box_centered(strap + 1.0, 4.0, t + 2.0).translate([0, 6.0, t / 2.0]) - cylinder([-w / 4.0, -8.0, -1.0], "Z", 1.5, t + 2.0) - cylinder([w / 4.0, -8.0, -1.0], "Z", 1.5, t + 2.0)
