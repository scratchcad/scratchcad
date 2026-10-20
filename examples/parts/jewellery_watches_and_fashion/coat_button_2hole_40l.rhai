// Coat button, 40 ligne (25.4 mm): 4 mm raised rim, 2.6 mm thick centre well, two 2.5 mm holes 5 mm apart, rounded outer edge
let diameter = 25.4; // [15.0, 40.0] Button diameter (mm)
let rim_thickness = 4.0; // [2.5, 6.0] Rim thickness (mm)
let centre_thickness = 2.6; // [1.5, 4.0] Centre thickness (mm)
let rim_width = 3.5; // [2.0, 6.0] Rim width (mm)
let hole_diameter = 2.5; // [1.5, 4.0] Hole diameter (mm)
let hole_spacing = 5.0; // [3.0, 9.0] Hole spacing (mm)
let r = diameter / 2.0;
let tc = min(centre_thickness, rim_thickness - 0.5);
let rw = min(rim_width, r / 2.0);
let profile = sketch("XZ")
    .move_to(0, 0)
    .hline_to(r - 1.0)
    .arc_to(r, rim_thickness * 0.45, r - 0.8, rim_thickness)
    .hline_to(r - rw + 0.6)
    .line_to(r - rw, tc + 0.4)
    .arc_to(r - rw - 0.6, tc + 0.05, r - rw - 1.2, tc)
    .hline_to(0)
    .close();
let button = profile.to_face().revolve("Z", 360);
let s = min(hole_spacing, (r - rw - 1.2) * 1.5) / 2.0;
button - cylinder([s, 0, -1], "Z", hole_diameter / 2.0, rim_thickness + 2.0) - cylinder([-s, 0, -1], "Z", hole_diameter / 2.0, rim_thickness + 2.0)
