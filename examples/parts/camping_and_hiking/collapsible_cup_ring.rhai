// Collapsible camp cup rigid rim: 80 mm diameter, 10 mm tall, flared lip and a 25 mm fold-out handle
let diameter = 80.0; // [60.0, 100.0] Rim diameter (mm)
let height = 10.0; // [6.0, 15.0] Rim height (mm)
let wall = 2.0; // [1.2, 3.0] Wall (mm)
let profile = sketch("XZ").move_to(diameter / 2.0 - wall, 0).hline_to(diameter / 2.0).vline_to(height - 2.0).line_to(diameter / 2.0 + 2.0, height).hline_to(diameter / 2.0 - wall).close();
let ring = profile.face().revolve("Z", 360);
let handle = box_from_corners([diameter / 2.0 - 0.5, -8.0, 0], [diameter / 2.0 + 25.0, 8.0, 3.0]);
let h = handle.fillet(7.9, handle.edges("|Z and >X")) - box_from_corners([diameter / 2.0 + 5.0, -4.0, -1], [diameter / 2.0 + 18.0, 4.0, 4.0]);
ring + h
