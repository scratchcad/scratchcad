// Lipstick case, 20 mm: 40 mm base with a 18.4 mm collar 15 mm tall and 15 mm bore for the swivel cup, and a 30 mm slip-on cap with a 0.2 mm snap bead, shown side by side
let diameter = 20.0; // [16.0, 26.0] Case diameter (mm)
let base_height = 40.0; // [25.0, 60.0] Base height (mm)
let collar_height = 15.0; // [8.0, 25.0] Collar height (mm)
let cap_height = 30.0; // [20.0, 45.0] Cap height (mm)
let bore = 15.0; // [10.0, 20.0] Swivel bore diameter (mm)
let ro = diameter / 2.0;
let rc = ro - 0.8;
let rb = min(bore / 2.0, rc - 0.8);
let base = cylinder(ro, base_height).fillet(1.0, "<Z") + cylinder([0, 0, base_height - 0.1], "Z", rc, collar_height + 0.1);
base = base - cylinder([0, 0, 3.0], "Z", rb, base_height + collar_height);
// snap groove near the bottom of the collar
base = base - (cylinder([0, 0, base_height + 1.5], "Z", rc + 1.0, 0.8) - cylinder([0, 0, base_height + 1.0], "Z", rc - 0.25, 2.0));
// cap: inner wall clears the collar by 0.1 mm, bead near its rim
let cap = cylinder(ro, cap_height).fillet(1.0, ">Z") - cylinder([0, 0, -1], "Z", rc + 0.1, cap_height - 1.0);
cap = cap + (cylinder([0, 0, 1.6], "Z", rc + 0.15, 0.6) - cylinder([0, 0, 1.0], "Z", rc - 0.1, 2.0));
[base, cap.translate([diameter + 8.0, 0, 0])]
