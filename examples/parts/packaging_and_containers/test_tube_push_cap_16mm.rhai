// Push-on test tube cap for 16 mm tubes: 16.1 mm bore 12 mm deep, 0.9 mm skirt, 2 mm top with an inner sealing plug ring for the 13.8 mm tube bore, and two 6 mm grip wings
let tube_diameter = 16.0; // [10.0, 25.0] Tube outside diameter (mm)
let tube_wall = 1.1; // [0.6, 1.8] Tube wall (mm)
let depth = 12.0; // [6.0, 20.0] Cap depth (mm)
let wall = 0.9; // [0.6, 1.5] Skirt wall (mm)
let wing = 6.0; // [0.0, 10.0] Grip wing width (mm)
let rb = tube_diameter / 2.0 + 0.05;
let ro = rb + wall;
const top = 2.0;
let cap = cylinder(ro, depth + top).fillet(0.8, ">Z") - cylinder([0, 0, -1], "Z", rb, depth + 1.0);
cap = cap.chamfer(0.3, cap.edges("%CIRCLE and <Z").sort_by(|e| e.radius()).first());
// plug ring that slips into the tube's bore
let rplug = tube_diameter / 2.0 - tube_wall - 0.05;
cap = cap + (cylinder([0, 0, depth - 5.0], "Z", rplug, 5.1) - cylinder([0, 0, depth - 6.0], "Z", rplug - 0.8, 7.0));
if wing > 0.0 {
    cap = cap + box_centered(2.0 * ro + 2.0 * wing, 1.2, top + 3.0).translate([0, 0, depth + top / 2.0 - 1.4]).fillet(min(wing / 2.0, 2.0), "|Y and >Z");
}
cap
