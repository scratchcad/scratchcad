// Sash window cam lock: 60 x 18 x 3 mm base with two holes, 30 mm half-disc cam on a 6 mm pivot, 40 mm lever; separate keeper
let lever_len = 40.0; // [25.0, 60.0] Lever length (mm)
let base = box_centered(60.0, 18.0, 3.0).translate([0, 0, 1.5]).fillet(2.0, "|Z");
for x in [-22.0, 22.0] { base -= cylinder([x, 0, -1], "Z", 2.0, 5.0); }
let cam = (cylinder([0, 0, 3.0], "Z", 15.0, 3.0) & box_from_corners([-16.0, 0, 3.0], [16.0, 16.0, 6.0])) + cylinder([0, 0, 3.0], "Z", 3.0, 8.0);
let lever = box_from_corners([-2.5, -lever_len, 9.0], [2.5, 3.0, 11.0]) + sphere([0, -lever_len, 10.0], 4.0);
let keeper = box_from_corners([-20.0, 20.0, 0], [20.0, 34.0, 3.0]) + box_from_corners([-16.0, 20.0, 3.0], [16.0, 23.0, 8.0]);
for x in [-14.0, 14.0] { keeper -= cylinder([x, 29.0, -1], "Z", 2.0, 5.0); }
compound([fuse_all([base, cam, lever]), keeper])
