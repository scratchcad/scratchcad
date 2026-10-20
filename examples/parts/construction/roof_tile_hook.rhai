// Solar roof hook for interlocking tiles: 6 mm steel base plate 140 x 60 mm with four 8 mm slots, cranked arm 25 x 6 mm rising 70 mm and returning 120 mm
let rise = 70.0; // [40.0, 110.0] Tile clearance (mm)
let base = box_centered(140.0, 60.0, 6.0).translate([0, 0, 3.0]).fillet(6.0, "|Z");
for x in [-50.0, -20.0] { for y in [-18.0, 18.0] { base -= box_centered(16.0, 8.0, 10.0).translate([x, y, 3.0]) + cylinder([x - 8.0, y, -1], "Z", 4.0, 8.0) + cylinder([x + 8.0, y, -1], "Z", 4.0, 8.0); } }
let prof = polygon([[-3, -12.5, 0], [3, -12.5, 0], [3, 12.5, 0], [-3, 12.5, 0]]);
let arm = prof.to_face().translate([60.0, 0, 5.0]).sweep(polyline([[60.0, 0, 5.0], [60.0, 0, rise], [-60.0, 0, rise + 5.0], [-60.0, 0, rise - 15.0]]));
base + arm
