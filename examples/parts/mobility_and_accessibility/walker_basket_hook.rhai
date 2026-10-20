// Walker bag hook: clip-on hook for a 25 mm walker frame tube, 30 mm wide C-clip with 4 mm wall and 75 percent wrap, 45 mm drop to a J-hook 25 mm deep with a 6 mm safety lip, holds shopping bags up to 5 kg
// # Clip
let tube = 25.0; // [19.0, 32.0] Frame tube diameter (mm)
let width = 30.0; // [20.0, 40.0] Hook width (mm)
let wall = 4.0; // [3.0, 6.0] Wall thickness (mm)
// # Hook
let drop = 45.0; // [25.0, 70.0] Drop below the tube (mm)
let hook_depth = 25.0; // [15.0, 40.0] Hook depth (mm)
let ro = tube / 2.0 + wall;
let ring = cylinder([0, 0, 0], "Y", ro, width);
let bore = cylinder([0, -1.0, 0], "Y", tube / 2.0, width + 2.0);
let mouth = box_from_corners([tube * 0.12, -1.0, 0], [ro + 1.0, width + 1.0, ro + 1.0]).rotate([0, 0, 0], "Y", -20.0);
let stem = box_from_corners([-ro, 0, -ro - drop], [-ro + wall + 1.0, width, 0]);
let base = box_from_corners([-ro, 0, -ro - drop - wall], [-ro + hook_depth + wall, width, -ro - drop]);
let lip = box_from_corners([-ro + hook_depth, 0, -ro - drop - 0.01], [-ro + hook_depth + wall, width, -ro - drop + 6.0 + 0.01]);
let body = (ring + stem + base + lip) - bore - mouth;
body.fillet(1.0, "|Y and <Z")
