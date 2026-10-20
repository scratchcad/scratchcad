// RC boat rudder: 40 x 25 mm blade 3 mm thick with a swept trailing edge, 3 mm shaft bore 50 mm along the leading edge in a 6 mm boss that runs 7 mm into the hull above the blade
let span = 40.0; // [25.0, 70.0] Blade depth (mm)
let chord = 25.0; // [15.0, 40.0] Blade chord (mm)
const t = 3.0;
let blade = face(polygon([[0, 0, 0], [chord, 0, -4.0], [chord * 0.85, 0, -span], [0, 0, -span]])).extrude([0, t, 0]).translate([0, -t / 2.0, 0]);
let boss = cylinder([0, 0, -span], "Z", 3.0, span + 10.0);
blade + boss - cylinder([0, 0, -span + 3.0], "Z", 1.55, span + 10.0)
