// Combination square head: 100 x 25 x 30 mm with a 45 deg face, 21 x 2 mm blade slot, 10 mm level vial bore and scriber hole
let len = 100.0; // [75.0, 120.0] Head length (mm)
let head = polygon([[0, 0, 0], [len, 0, 0], [len, 0, 30.0], [30.0, 0, 30.0], [0, 0, 0]]).to_face().extrude([0, 25.0, 0]);
head -= box_from_corners([-1.0, 11.5, 22.0], [len + 1.0, 13.5, 31.0]);
head -= cylinder([len - 45.0, 12.5, 15.0], "X", 5.0, 40.0) + box_centered(25.0, 6.0, 20.0).translate([len - 25.0, 12.5, 2.0]);
head - cylinder([len - 8.0, 12.5, -1.0], "Z", 2.0, 30.0) - cylinder([len * 0.35, -1, 10.0], "Y", 3.0, 27.0)
