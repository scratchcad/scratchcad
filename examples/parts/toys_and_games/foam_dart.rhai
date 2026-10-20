// Foam blaster dart: 12.7 mm foam body 72 mm long with a 3 mm hollow core, 13.5 mm rubber suction tip 10 mm long
let len = 72.0; // [50.0, 100.0] Body length (mm)
let foam = cylinder(6.35, len) - cylinder([0, 0, -1], "Z", 1.5, len - 6.0);
let tip = cylinder([0, 0, len - 4.0], "Z", 5.0, 5.0) + (cylinder([0, 0, len], "Z", 6.75, 6.0).fillet(2.0, ">Z") - sphere([0, 0, len + 10.5], 5.0));
compound([foam, tip])
