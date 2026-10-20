// Redemption ticket dispenser exit guide: 40 x 30 mm bezel 3 mm thick with a 32 x 3 mm ticket slot, a 10 mm tall guide throat behind it and two 3 mm screw holes
let ticket = 32.0; // [25.0, 45.0] Ticket width (mm)
let throat = 10.0; // [6.0, 20.0] Guide throat depth (mm)
let w = ticket + 8.0;
let bezel = box_centered(w, 30.0, 3.0).translate([0, 0, 1.5]);
let guide = box_centered(ticket + 4.0, 7.0, throat).translate([0, 0, -throat / 2.0 + 0.01]);
bezel + guide - box_centered(ticket, 3.0, throat + 10.0).translate([0, 0, 0]) - cylinder([-w / 2.0 + 3.0, 10.0, -1.0], "Z", 1.5, 5.0) - cylinder([w / 2.0 - 3.0, 10.0, -1.0], "Z", 1.5, 5.0)
