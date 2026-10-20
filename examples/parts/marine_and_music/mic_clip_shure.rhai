// Microphone clip for 23 mm handles: open C clamp 6 mm wall 25 mm wide, pivot knuckle with 5/8-27 UNS stand thread bore
let handle = 23.0; // [19.0, 32.0] Mic handle diameter (mm)
let r = handle / 2.0;
let clip = cylinder([0, -12.5, 0], "Y", r + 3.0, 25.0) - cylinder([0, -13.0, 0], "Y", r, 26.0) - polygon([[0, 0, 0], [30, 0, 22], [-30, 0, 22]]).to_face().extrude([0, 30.0, 0]).translate([0, -15.0, 0]);
let knuckle = box_from_corners([-8.0, -12.5, -r - 14.0], [8.0, 12.5, -r - 1.0]) - cylinder([-9.0, 0, -r - 8.0], "X", 3.0, 18.0);
let mount = cylinder([0, 0, -r - 40.0], "Z", 9.0, 20.0) - cylinder([0, 0, -r - 41.0], "Z", 7.9, 16.0);
let ears = box_from_corners([-12.0, -6.0, -r - 22.0], [-8.5, 6.0, -r - 1.0]) + box_from_corners([8.5, -6.0, -r - 22.0], [12.0, 6.0, -r - 1.0]) + box_from_corners([-12.0, -6.0, -r - 22.0], [12.0, 6.0, -r - 19.0]);
fuse_all([clip, knuckle, ears + mount])
