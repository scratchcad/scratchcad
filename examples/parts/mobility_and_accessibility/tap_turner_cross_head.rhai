// Cross-head tap turner: 150 mm lever that pushes over a 4-spoke cross tap head up to 55 mm across, 60 mm round socket 25 mm deep with a 14 mm wide cross recess, 25 mm lever bar 18 mm thick with rounded end
// # Socket
let head_span = 55.0; // [40.0, 70.0] Tap head span (mm)
let spoke_width = 14.0; // [8.0, 20.0] Spoke width (mm)
let socket_depth = 20.0; // [12.0, 30.0] Socket depth (mm)
// # Lever
let lever_length = 150.0; // [100.0, 220.0] Lever length (mm)
let lever_width = 25.0; // [18.0, 35.0] Lever width (mm)
let lever_t = 18.0; // [12.0, 22.2] Lever thickness (mm)
let ro = head_span / 2.0 + 4.0;
let hub = cylinder(ro, socket_depth + 4.0);
let bar = box_from_corners([0, -lever_width / 2.0, 0], [lever_length, lever_width / 2.0, lever_t]).fillet(lever_width / 2.0 - 0.5, "|Z and >X");
let body = (hub + bar).fillet(1.5, ">Z");
let cross = fuse_all([box_centered(head_span + 1.0, spoke_width + 1.0, socket_depth * 2.0), box_centered(spoke_width + 1.0, head_span + 1.0, socket_depth * 2.0)]).translate([0, 0, -0.01]);
let centre = cylinder([0, 0, -1.0], "Z", spoke_width * 0.9, socket_depth + 1.0);
body - cross - centre
