// Handrail wall bracket: 65 mm round rose 8 mm, 70 mm projection arm 14 mm, saddle for a 42 mm rail with 2 screw holes
let rose = 65.0; // [50.0, 80.0] Rose diameter (mm)
let reach = 70.0; // [55.0, 90.0] Wall to rail centre (mm)
let rail = 42.0; // [35.0, 50.0] Rail diameter (mm)
let r = cylinder([0, 0, 0], "Y", rose / 2.0, 8.0);
let arm = cylinder([0, 7.99, 0], "Y", 7.0, reach - rail / 2.0 - 8.0 + 2.0);
let saddle = (cylinder([-20.0, reach, 0], "X", rail / 2.0 + 4.0, 40.0) - cylinder([-21.0, reach, 0], "X", rail / 2.0, 42.0)) & box_from_corners([-20.0, reach - rail, -rail], [20.0, reach - rail * 0.25, rail]);
let pad = box_from_corners([-20.0, reach - rail / 2.0 - 4.0, -6.0], [20.0, reach - rail / 2.0 + 1.0, 6.0]);
r + arm + (saddle & box_from_corners([-20.0, 0, -8.0], [20.0, reach, 8.0])) + pad - cylinder([0, -1, rose * 0.3], "Y", 2.5, 10.0) - cylinder([0, -1, -rose * 0.3], "Y", 2.5, 10.0)
