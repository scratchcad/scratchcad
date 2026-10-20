// Bench vise jaw plate: 100 x 25 x 10 mm hardened steel with horizontal and vertical V-grooves, two M8 counterbored holes 70 mm apart
let w = 100.0; // [75.0, 150.0] Jaw width (mm)
let jaw = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, 10.0, 25.0]);
let vee = polygon([[0, -0.01, -3.0], [0, 3.0, 0], [0, -0.01, 3.0]]).to_face().extrude([1, 0, 0]);
jaw -= polygon([[-w / 2.0 - 1.0, -0.01, 9.5], [-w / 2.0 - 1.0, 3.0, 12.5], [-w / 2.0 - 1.0, -0.01, 15.5]]).to_face().extrude([w + 2.0, 0, 0]);
jaw -= polygon([[-3.0, -0.01, -1.0], [0, 3.0, -1.0], [3.0, -0.01, -1.0]]).to_face().extrude([0, 0, 27.0]);
for x in [-35.0, 35.0] { jaw -= cylinder([x, -1, 12.5], "Y", 4.5, 12.0) + cylinder([x, -1, 12.5], "Y", 7.5, 6.5); }
jaw
