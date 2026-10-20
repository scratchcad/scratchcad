// Desk photo and postcard stand: 50 mm round weighted puck 18 mm tall with a 1.2 mm slit 12 mm deep leaning back 8 degrees for a postcard or 10 x 15 cm photo, 1.5 mm chamfered mouth, 2 mm edge round
let diameter = 50.0; // [35.0, 80.0] Puck diameter (mm)
let height = 18.0; // [12.0, 30.0] Puck height (mm)
let slit = 1.2; // [0.6, 3.0] Slit width (mm)
let slit_depth = 12.0; // [6.0, 20.0] Slit depth (mm)
let lean = 8.0; // [0.0, 20.0] Lean back (degrees)

let puck = cylinder(diameter / 2.0, height);
puck = puck.fillet(2.0, puck.edges(">Z"));
puck = puck.chamfer(0.6, puck.edges("<Z"));
let sd = min(slit_depth, height - 4.0);
let slot = box_centered(diameter + 2.0, slit, 2.0 * sd).rotate_x(-lean).translate([0, 0, height]);
let mouth = polygon([[-diameter, -slit / 2.0 - 1.5, 1.0], [-diameter, 0, -1.5], [-diameter, slit / 2.0 + 1.5, 1.0]]).to_face().extrude([2.0 * diameter, 0, 0]).rotate_x(-lean).translate([0, 0, height]);
puck - (slot + mouth)
