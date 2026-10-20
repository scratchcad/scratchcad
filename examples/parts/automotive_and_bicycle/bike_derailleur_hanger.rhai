// Replaceable derailleur hanger: 5 mm alloy plate, axle notch for a 9 mm QR, 7 mm thick boss with M10x1 hole, two countersunk M4 holes
let t = 5.0; // [4.0, 7.0] Plate thickness (mm)
let plate = polygon([[0, 0], [30, 0], [34, 12], [30, 34], [22, 42], [8, 42], [0, 30]]).to_face().extrude(t);
let hanger = plate + cylinder([15, 32, 0], "Z", 8.0, 7.0);
hanger -= cylinder([15, -3, -1], "Z", 5.0, t + 2.0);
hanger -= cylinder([15, 32, -1], "Z", 5.0, 9.0);
for x in [6.0, 26.0] { hanger -= cylinder([x, 9.0, -1], "Z", 2.1, t + 2.0) + cone(2.1, 4.1, 2.0).translate([x, 9.0, t - 2.0 + 0.001]); }
hanger
