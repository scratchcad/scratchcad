// Radial electrolytic capacitor 10 x 16 mm: sleeve with a 0.5 mm top vent cross, rolled groove, 5 mm lead spacing
let diameter = 10.0; // [6.4, 25.0] Diameter (mm)
let height = 16.0; // [5.0, 50.0] Height (mm)
let lead_spacing = 5.0; // [1.5, 10.0] Lead spacing (mm)
let can = cylinder([0, 0, 0.5], "Z", diameter / 2.0, height).fillet(0.5, ">Z");
can = can - torus(diameter / 2.0 + 0.2, 0.4).translate([0, 0, 2.0]);
can = can - box_centered(diameter * 0.6, 0.5, 0.6).translate([0, 0, height + 0.5]) - box_centered(0.5, diameter * 0.6, 0.6).translate([0, 0, height + 0.5]);
let leads = cylinder([-lead_spacing / 2.0, 0, -4.0], "Z", 0.3, 4.6) + cylinder([lead_spacing / 2.0, 0, -4.0], "Z", 0.3, 4.6);
can + leads
