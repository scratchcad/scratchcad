// Snap-on cover for 25 mm wide slotted wiring duct, 200 mm long: 25.4 mm wide 1.6 mm strip with 0.6 mm rounded top edges and two 3 mm deep retaining ribs underneath that sit 0.2 mm inside the 1.6 mm duct walls
let length = 200.0; // [50.0, 500.0] Cover length (mm)
let duct_width = 25.0; // [15.0, 80.0] Duct width (mm)
let rib_depth = 3.0; // [2.0, 5.0] Rib depth (mm)
const t = 1.6;
const duct_wall = 1.6;
const rib_t = 1.0;
let w = duct_width + 0.4;
let top = box_from_corners([0, -w / 2.0, 0], [length, w / 2.0, t]);
let top = top.fillet(0.6, top.edges("|X and >Z"));
let ry = duct_width / 2.0 - duct_wall - 0.2;
let ribs = box_from_corners([0, ry - rib_t, -rib_depth], [length, ry, 0.5]) + box_from_corners([0, -ry, -rib_depth], [length, -ry + rib_t, 0.5]);
top + ribs
