// Awning pole tip pin: 22 mm tube insert 30 mm, 8 mm pin 25 mm for tarp eyelets, 26 mm stop collar 5 mm
let tube_id = 22.0; // [15.0, 30.0] Pole inside diameter (mm)
let pin = 8.0; // [5.0, 12.0] Pin diameter (mm)
let pin_l = 25.0; // [15.0, 40.0] Pin length (mm)
let insert = cylinder([0, 0, -30.0], "Z", tube_id / 2.0, 30.01) - cylinder([0, 0, -31.0], "Z", tube_id / 2.0 - 2.5, 28.0);
let collar = cylinder(tube_id / 2.0 + 2.0, 5.0);
let p = cylinder([0, 0, 4.99], "Z", pin / 2.0, pin_l) + cone(pin / 2.0, 1.0, pin / 2.0).translate([0, 0, 4.99 + pin_l - 0.01]);
insert + collar + p
