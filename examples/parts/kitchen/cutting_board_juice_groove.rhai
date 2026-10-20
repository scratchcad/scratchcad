// End-grain style cutting board: 400 x 250 x 20 mm, 8 mm round-bottomed juice groove 15 mm in from the edges, finger-grip recesses on both short ends, 3 mm edge round-over
let length = 400.0; // [200.0, 600.0] Board length (mm)
let width = 250.0; // [150.0, 400.0] Board width (mm)
let thickness = 20.0; // [12.0, 40.0] Board thickness (mm)
let groove_width = 8.0; // [4.0, 14.0] Groove width (mm)
let groove_inset = 15.0; // [10.0, 30.0] Groove distance from the edge (mm)
let corner_radius = 20.0; // [5.0, 40.0] Groove corner radius (mm)
let board = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]).fillet(10.0, "|Z").fillet(3.0, ">Z or <Z");
// groove: a circle swept round a rounded rectangle on the top face
let inset = groove_inset + groove_width / 2.0;
let path = rect(length - 2.0 * inset - 2.0 * corner_radius, width - 2.0 * inset - 2.0 * corner_radius).offset(corner_radius).translate([0, 0, thickness]);
let first = path.edges()[0];
let groove = face(circle(first.start_point(), first.tangent_at(0.0), groove_width / 2.0)).sweep(path);
board = board - groove;
// finger grips under the short ends
for s in [-1.0, 1.0] {
    board -= cylinder([s * (length / 2.0 + 10.0), -40.0, -6.0], "Y", 14.0, 80.0);
}
board
