// Drip irrigation emitter, 2 l/h button: 22 mm button, 4 mm barb inlet, outlet nipple, labyrinth rib ring
let diameter = 22.0; // [16.0, 30.0] Button diameter (mm)
let height = 8.0; // [6.0, 12.0] Button height (mm)
let body = cylinder(diameter / 2.0, height);
let b = body.fillet(1.5, body.edges(">Z"));
let barb = cone(2.6, 1.6, 8.0).rotate_x(180.0) + cylinder([0, 0, -0.01], "Z", 1.6, 0.02);
let inlet = barb.translate([0, 0, 0.01]);
let outlet = cylinder([0, 0, height - 0.01], "Z", 2.0, 5.0);
let rib = cylinder([0, 0, height / 2.0 - 1.0], "Z", diameter / 2.0 + 0.6, 2.0) - cylinder([0, 0, 0], "Z", diameter / 2.0 - 0.1, height);
b + inlet + outlet + rib - cylinder([0, 0, -10.0], "Z", 0.8, height + 20.0)
