// Retractable utility knife body: 150 x 20 mm profile 18 mm thick, blade channel 19 x 1 mm, slider slot and thumb button
let len = 150.0; // [120.0, 180.0] Length (mm)
let body = polygon([[0, 0], [len - 25.0, 0], [len, 6.0], [len, 14.0], [len - 25.0, 20.0], [15.0, 22.0], [0, 16.0]]).to_face().extrude(18.0).fillet(2.0, "|Z");
body -= box_from_corners([20.0, 4.0, 8.5], [len + 1.0, 16.0, 9.5]);
body -= box_from_corners([50.0, 9.0, 17.0], [110.0, 13.0, 19.0]);
body + box_from_corners([75.0, 7.0, 17.5], [85.0, 15.0, 21.0]).fillet(1.0, ">Z")
