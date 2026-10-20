// NATO clamp base for a top handle: 50 x 30 x 15 mm body with a 21.4 mm 45 degree dovetail channel underneath (15.8 mm neck), M5 clamp screw hole (4.2 mm) from the side, 4 mm spring-pin hole across the top for the safety pin, and an ARRI-style 3/8-16 tapped hole (8 mm core) plus two M4 locating holes (3.3 mm) 16 mm apart across it in the top
let length = 50.0; // [30.0, 80.0] Clamp length (mm)
let width = 30.0; // [28.0, 40.0] Clamp width (mm)
let height = 15.0; // [14.0, 25.0] Clamp height (mm)
let body = box_centered(length, width, height).translate([0, 0, height / 2.0]);
let body = body.fillet(2.0, body.edges("|Y"));
let channel = face(polygon([
    [0, -7.9, -1.0], [0, 7.9, -1.0], [0, 7.9, 3.2], [0, 10.7, 6.0], [0, 10.7, 7.5], [0, -10.7, 7.5],
    [0, -10.7, 6.0], [0, -7.9, 3.2]])).extrude([length + 2.0, 0, 0]).translate([-length / 2.0 - 1.0, 0, 0]);
let clamp_screw = cylinder([0, width / 2.0 + 1.0, 4.5], "-Y", 2.1, width / 2.0 - 6.0);
let pin = cylinder([-length / 2.0 + 5.0, -width / 2.0 - 1.0, height - 3.5], "Y", 2.0, width + 2.0);
let top_tap = cylinder([0, 0, 8.5], "Z", 4.0, height);
let locs = cylinder([0, -8.0, 9.0], "Z", 1.65, height) + cylinder([0, 8.0, 9.0], "Z", 1.65, height);
body - channel - clamp_screw - pin - top_tap - locs
