// Pop-up sprinkler head: 40 mm cap, 25 mm riser 30 mm extended, nozzle with an 8 mm deflector, 1/2 in inlet
let cap_d = 40.0; // [34.0, 70.0] Cap diameter (mm)
let riser_d = 25.0; // [15.0, 30.4] Riser diameter (mm)
let rise = 30.0; // [0.0, 100.0] Pop-up height (mm)
let body = cylinder([0, 0, -80.0], "Z", cap_d / 2.0 - 3.0, 80.0) + (cylinder(cap_d / 2.0, 5.0) - cylinder([0, 0, -1], "Z", riser_d / 2.0 + 0.5, 8.0)).fillet(1.5, ">Z");
let riser = cylinder([0, 0, -40.0], "Z", riser_d / 2.0, 40.0 + rise) + cone(riser_d / 2.0, 4.0, 6.0).translate([0, 0, rise]);
let deflector = (cylinder([0, 0, rise + 6.0], "Z", 4.0, 4.0) & box_centered(10.0, 10.0, 10.0).translate([5.0, 0, rise + 8.0])).rotate_y(0);
let inlet = cylinder([0, 0, -95.0], "Z", 10.5, 15.01);
[body + inlet, riser - cylinder([0, 0, rise + 2.0], "X", 1.2, 20.0)]
