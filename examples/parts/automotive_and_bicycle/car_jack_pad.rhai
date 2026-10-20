// Pinch-weld jack pad: 70 mm rubber puck 25 mm tall with a 12 mm wide 12 mm deep slot, 26 mm locating spigot
let d = 70.0; // [55.0, 90.0] Pad diameter (mm)
let pad = cylinder(d / 2.0, 25.0).fillet(3.0, ">Z") - box_centered(d + 10.0, 12.0, 24.0).translate([0, 0, 25.0]);
pad + cylinder([0, 0, -10.0], "Z", 13.0, 10.5)
