// Eyewash station dust cap: flip-off cap for a 45 mm eyewash spray head, 52 mm OD x 18 mm, 2 mm wall, 10 mm tether tab with a 4 mm hole
let head = 45.0; // [35.0, 60.0] Spray head diameter (mm)
let height = 18.0; // [12.0, 25.0] Cap height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let od = head + 2.0 * wall + 3.0;
let p = sketch("XZ").move_to(0, 0).hline_to(od / 2.0 - 2.0).line_to(od / 2.0, 2.0).vline_to(height).hline_to(od / 2.0 - wall).vline_to(wall + 1.5).line_to(head / 2.0 - 4.0, wall).hline_to(0).close();
let cap = p.to_face().revolve([0, 0, 0], "Z", 360).rotate_x(180.0).translate([0, 0, height]);
let tab = box_from_corners([od / 2.0 - 1.0, -5.0, height - 2.0], [od / 2.0 + 10.0, 5.0, height]);
let tb = tab.fillet(4.0, tab.edges("|Z and >X"));
// a small snap bead inside the skirt
let bead = (cylinder([0, 0, 2.0], "Z", od / 2.0 - wall + 0.01, 1.2) - cylinder([0, 0, 1.0], "Z", od / 2.0 - wall - 0.6, 4.0));
cap + tb + bead - cylinder([od / 2.0 + 5.0, 0, height - 3.0], "Z", 2.0, 4.0)
