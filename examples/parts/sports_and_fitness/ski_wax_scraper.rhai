// Ski and snowboard wax scraper: 150 x 60 mm, 5 mm acrylic plate, 8 mm corner radius on the handle end, square scraping edges, edge-groove comb notch 40 mm on one short side, 12 mm hang hole
let length = 150.0; // [100.0, 200.0] Length (mm)
let width = 60.0; // [40.0, 90.0] Width (mm)
let thickness = 5.0; // [3.0, 6.0] Thickness (mm)
let notch_length = 40.0; // [20.0, 50.0] Edge notch length (mm)
let notch_depth = 3.0; // [1.5, 6.0] Edge notch depth (mm)
let hole_d = 12.0; // [0.0, 20.0] Hang hole diameter (mm)
let plate = box_centered(length, width, thickness).translate([0, 0, thickness / 2.0]);
plate = plate.fillet(8.0, plate.edges("|Z").filter(|e| e.center().x < 0.0));
let nl = min(notch_length, width - 10.0);
plate = plate - box_centered(notch_depth * 2.0, nl, thickness + 2.0).translate([length / 2.0, 0, thickness / 2.0]);
plate = plate - box_centered(1.0, nl - 4.0, thickness + 2.0).translate([length / 2.0 - notch_depth - 0.5, 0, thickness / 2.0]);
if hole_d > 0.5 { plate = plate - cylinder([-length / 2.0 + min(hole_d, width / 2.0) / 2.0 + 8.0, 0, -1.0], "Z", min(hole_d, width / 2.0) / 2.0, thickness + 2.0); }
plate
