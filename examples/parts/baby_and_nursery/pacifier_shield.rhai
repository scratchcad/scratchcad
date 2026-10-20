// Pacifier shield: 45 x 35 mm butterfly shield 2 mm with 2 vent holes 6 mm, 10 mm nipple socket, ring hinge lugs
let width = 45.0; // [38.0, 55.0] Shield width (mm)
let height = 35.0; // [28.0, 45.0] Shield height (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let shield = polygon([[-width / 2.0, -height * 0.25], [-width * 0.3, -height / 2.0], [width * 0.3, -height / 2.0], [width / 2.0, -height * 0.25], [width / 2.0, height * 0.25], [width * 0.3, height / 2.0], [-width * 0.3, height / 2.0], [-width / 2.0, height * 0.25]]).to_face().extrude([0, 0, t]);
let s = shield.fillet(6.0, shield.edges("|Z"));
let socket = cylinder([0, 0, -10.0], "Z", 6.0, 10.01) - cylinder([0, 0, -11.0], "Z", 4.0, 10.0);
let lugs = box_from_corners([-6.0, -2.0, t - 0.01], [-4.0, 2.0, 7.0]) + box_from_corners([4.0, -2.0, t - 0.01], [6.0, 2.0, 7.0]);
s + socket + lugs - cylinder([-13.0, 0, -1], "Z", 3.0, t + 2.0) - cylinder([13.0, 0, -1], "Z", 3.0, t + 2.0) - cylinder([-7.0, 0, 5.0], "X", 1.0, 14.0)
