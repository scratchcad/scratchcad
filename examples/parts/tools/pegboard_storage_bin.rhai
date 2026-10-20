// Pegboard storage bin: 100 x 60 x 60 mm, 2 mm walls, low sloped front with label lip, two hook tabs on the back for 6 mm holes at 25.4 mm
let w = 100.0; // [60.0, 200.0] Width (mm)
let d = 60.0; // [40.0, 100.0] Depth (mm)
let side = polygon([[0, 0, 0], [0, 0, 60.0], [d, 0, 35.0], [d, 0, 0]]).to_face().extrude([0, w, 0]);
let inner = polygon([[2.0, 0, 2.0], [2.0, 0, 70.0], [d - 2.0, 0, 70.0], [d - 2.0, 0, 2.0]]).to_face().extrude([0, w - 4.0, 0]).translate([0, 2.0, 0]);
let bin = side - inner;
bin += box_from_corners([d - 2.0, 0, 25.0], [d + 6.0, w, 27.0]);
for y in [w / 2.0 - 12.7, w / 2.0 + 12.7] { bin += box_from_corners([-6.0, y - 2.5, 50.0], [0.01, y + 2.5, 54.0]) + box_from_corners([-6.0, y - 2.5, 54.0], [-2.0, y + 2.5, 64.0]); }
bin
