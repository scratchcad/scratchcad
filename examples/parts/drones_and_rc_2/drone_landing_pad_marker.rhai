// Drone landing pad corner peg: 120 mm ground spike 6 mm, 30 mm head with a 4 mm slot for a 3 mm pad edge
let spike = 120.0; // [80.0, 180.0] Spike length (mm)
let head = 30.0; // [20.0, 40.0] Head diameter (mm)
let s = cylinder([0, 0, 15.0], "Z", 3.0, spike - 15.0) + cone(0.5, 3.0, 15.01);
let h = cylinder([0, 0, spike - 0.01], "Z", head / 2.0, 10.0) - box_centered(head + 2.0, 4.0, 6.0).translate([head / 2.0, 0, spike + 6.0]);
s + h
