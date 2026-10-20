// Figure-8 end closure for 16 mm drip line: 16.5 mm ring for the line and a 17 x 9 mm slot for the folded-back end, 8 mm thick
let line_diameter = 16.0; // [12.0, 25.0] Drip line diameter (mm)
let thickness = 8.0; // [5.0, 12.0] Thickness (mm)
let wall = 2.5; // [1.8, 4.0] Wall (mm)
let ri = line_diameter / 2.0 + 0.25;
let ro = ri + wall;
let fold = line_diameter * 0.55;
let dy = ro + fold / 2.0 + wall - 0.5;
let body = fuse_all([cylinder(ro, thickness),
                     box_from_corners([-ro, 0, 0], [ro, dy, thickness]),
                     cylinder([-ri + fold / 2.0, dy, 0], "Z", fold / 2.0 + wall, thickness),
                     cylinder([ri - fold / 2.0, dy, 0], "Z", fold / 2.0 + wall, thickness),
                     box_from_corners([-ri + fold / 2.0, dy - fold / 2.0 - wall, 0], [ri - fold / 2.0, dy + fold / 2.0 + wall, thickness])]);
let slot = fuse_all([cylinder([-ri + fold / 2.0, dy, -1.0], "Z", fold / 2.0, thickness + 2.0),
                     cylinder([ri - fold / 2.0, dy, -1.0], "Z", fold / 2.0, thickness + 2.0),
                     box_from_corners([-ri + fold / 2.0, dy - fold / 2.0, -1.0], [ri - fold / 2.0, dy + fold / 2.0, thickness + 1.0])]);
(body - slot - cylinder([0, 0, -1.0], "Z", ri, thickness + 2.0)).fillet(0.6, ">Z or <Z")
