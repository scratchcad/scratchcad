// FTTH drop cable wedge clamp body: 80 mm tapered shell for a 2 x 5 mm flat drop cable, 20 mm wide tapering to 12 mm, with a 10 mm bail hook eye and 3 mm walls
let length = 80.0; // [60.0, 120.0] Clamp length (mm)
let cable_w = 5.0; // [3.0, 8.0] Flat cable width (mm)
const t = 3.0;
let shell = face(polygon([[0, -10.0, 0], [length, -6.0, 0], [length, 6.0, 0], [0, 10.0, 0]])).extrude([0, 0, 12.0]);
let channel = box_from_corners([-1.0, -cable_w / 2.0, t], [length + 1.0, cable_w / 2.0, 13.0]);
let eye = cylinder([-8.0, 0, 0], "Z", 8.0, 6.0) - cylinder([-8.0, 0, -1.0], "Z", 5.0, 8.0) + box_from_corners([-2.0, -4.0, 0], [0.01, 4.0, 6.0]);
shell - channel + eye
