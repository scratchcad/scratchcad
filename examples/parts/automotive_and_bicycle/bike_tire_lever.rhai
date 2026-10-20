// Nylon tyre lever: 113 mm long, 20 mm wide, 4 mm thick, upturned spoon tip with a lip, spoke hook notch at the other end
let width = 20.0; // [16.0, 24.0] Width (mm)
let pts = [[0, 0, 0], [95, 0, 0], [108, 0, 3], [111, 0, 1.5], [113, 0, 2.0], [113, 0, 6.5], [108, 0, 7.5], [95, 0, 4], [0, 0, 4]];
let lever = polygon(pts).to_face().extrude([0, width, 0]);
lever - box_from_corners([-1, width / 2.0 - 3.0, -1], [6, width / 2.0 + 3.0, 5]) - cylinder([6, width / 2.0, -1], "Z", 3.0, 6.0)
