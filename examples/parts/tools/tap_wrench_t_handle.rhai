// T-handle tap wrench for M3-M8: 16 mm body 55 mm long with a four-jaw collet slotted 1.5 mm, 8 mm square tap socket, 100 mm sliding T-bar
let bar = 100.0; // [70.0, 150.0] T-bar length (mm)
let body = cylinder(8.0, 55.0).chamfer(0.8, ">Z") - box_centered(6.0, 6.0, 30.0) - cone(5.0, 3.0, 4.0).translate([0, 0, -0.01]);
body -= box_centered(1.5, 20.0, 40.0) + box_centered(20.0, 1.5, 40.0);
body -= cylinder([-10.0, 0, 48.0], "X", 4.1, 20.0);
let tbar = cylinder([-bar / 2.0, 0, 48.0], "X", 4.0, bar) + sphere([-bar / 2.0, 0, 48.0], 5.0) + sphere([bar / 2.0, 0, 48.0], 5.0);
compound([body, tbar])
