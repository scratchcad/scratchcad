// Grab bar flange cover: snap-on escutcheon for a 38 mm (1 1/2 in) grab bar, 80 mm diameter, 12 mm tall dome-style cover with 2 mm wall, 38.6 mm bar bore and 0.8 mm snap lip
// # Fit
let bar = 38.0; // [25.0, 42.0] Grab bar diameter (mm)
let flange = 76.0; // [60.0, 90.0] Wall flange diameter (mm)
// # Cover
let height = 12.0; // [8.0, 20.0] Cover height (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
let ro = flange / 2.0 + wall + 0.5;
let outer = sketch("XZ").move_to(bar / 2.0 + 0.3, 0).hline_to(ro).vline(height * 0.4).line_to(bar / 2.0 + 3.0, height).hline_to(bar / 2.0 + 0.3).close().to_face().revolve("Z", 360);
let inner = sketch("XZ").move_to(bar / 2.0 + 2.0, -0.01).hline_to(ro - wall).vline(height * 0.4 - wall * 0.6).line_to(bar / 2.0 + 2.0, height - wall).close().to_face().revolve("Z", 360);
let lip = cylinder([0, 0, 0], "Z", ro - wall + 0.01, 1.2) - cylinder([0, 0, -1], "Z", ro - wall - 0.8, 4.0);
outer - inner + lip
