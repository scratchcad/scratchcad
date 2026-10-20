// Closed GT2 belt loop, 200 mm long, 6 mm wide, 1.38 mm thick with 100 teeth, as a racetrack around two 20T pulleys 68.6 mm apart
let width = 6.0; // [6.0, 15.0] Belt width (mm)
let centers = 68.6; // [20.0, 300.0] Pulley centers (mm)
let pd = 12.73; // [10.0, 60.0] Pulley pitch diameter (mm)
let thickness = 1.38;
let r_out = pd / 2.0 + 0.254 + 0.63;
let r_in = r_out - thickness + 0.75;
let racetrack = |r| face(wire([line([0, -r, 0], [centers, -r, 0]), arc([centers, -r, 0], [centers + r, 0, 0], [centers, r, 0]), line([centers, r, 0], [0, r, 0]), arc([0, r, 0], [-r, 0, 0], [0, -r, 0])]));
let belt = racetrack.call(r_out).extrude(width) - racetrack.call(r_in).extrude(width + 2.0).translate([0, 0, -1]);
belt
