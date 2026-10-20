// NP-F (L-series) battery plate for a camera cage: 75 x 46 x 4 mm base, two 3.5 mm tall rails 38.6 mm apart with 1.5 mm inward lips forming the battery's slide grooves, 2 mm end stop at one end, 14 x 9 mm contact window and a 1/4-20 clearance hole (6.5 mm) countersunk underneath
let length = 75.0; // [70.0, 90.0] Plate length (mm)
let rail_gap = 38.6; // [38.0, 40.0] Distance between the rails (mm)
let base_t = 4.0; // [3.0, 6.0] Base thickness (mm)
const rail_h = 3.5;
const rail_w = 3.0;
const lip = 1.5;
let width = rail_gap + 2.0 * rail_w + 1.4;
let base = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, base_t]);
let base = base.fillet(3.0, base.edges("|Z"));
let g = rail_gap / 2.0;
let rail_profile = polygon([[0, g, base_t - 0.5], [0, g + rail_w, base_t - 0.5], [0, g + rail_w, base_t + rail_h], [0, g - lip, base_t + rail_h], [0, g - lip, base_t + rail_h - 1.2], [0, g, base_t + rail_h - 1.2]]);
let rail_a = face(rail_profile).extrude([length - 6.0, 0, 0]).translate([3.0, 0, 0]);
let rail_b = rail_a.mirror([0, 0, 0], [0, 1, 0]);
let stop = box_from_corners([length - 5.0, -g, base_t - 0.5], [length - 3.0, g, base_t + 2.0]);
let window = box_centered(14.0, 9.0, base_t + 2.0).translate([length - 14.0, 0, base_t / 2.0]);
let hole = cylinder([length / 2.0 - 8.0, 0, -1.0], "Z", 3.25, base_t + 2.0);
let sink = cone(6.5, 3.25, 3.25).translate([length / 2.0 - 8.0, 0, -0.01]);
base + rail_a + rail_b + stop - window - hole - sink
