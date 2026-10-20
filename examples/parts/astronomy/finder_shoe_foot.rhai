// Synta-style finder foot: 32 mm dovetail base tapering to 25 mm, 9 mm tall, 50 mm long, with a 30 mm ring pedestal and 2 M4 screw holes
let length = 50.0; // [40.0, 70.0] Foot length (mm)
let base_w = 32.0; // [30.0, 34.0] Dovetail base width (mm)
const top_w = 25.0;
const height = 9.0;
let profile = polygon([[-base_w / 2.0, 0, 0], [base_w / 2.0, 0, 0], [top_w / 2.0, 0, height], [-top_w / 2.0, 0, height]]);
let foot = face(profile).extrude([0, length, 0]).translate([0, -length / 2.0, 0]);
let pedestal = box_from_corners([-8.0, -length / 2.0 + 5.0, height - 0.01], [8.0, length / 2.0 - 5.0, height + 12.0]);
let holes = cylinder([0, -length / 4.0, -1.0], "Z", 2.1, height + 15.0) + cylinder([0, length / 4.0, -1.0], "Z", 2.1, height + 15.0);
foot + pedestal - holes
