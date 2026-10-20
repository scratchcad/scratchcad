// CR2032 coin cell (20 x 3.2 mm) in a through-hole holder: 23 mm round base 4 mm tall with a retaining spring tab
let cell_d = 20.0; // [12.0, 24.5] Cell diameter (mm)
let cell_t = 3.2; // [1.6, 5.4] Cell thickness (mm)
let wall = 1.2; // [0.8, 2.0] Holder wall (mm)
let base = cylinder(cell_d / 2.0 + wall, cell_t + 1.0) - cylinder([0, 0, 1.0], "Z", cell_d / 2.0 + 0.2, cell_t + 1.0) - box_from_corners([-cell_d * 0.35, -cell_d, 1.0], [cell_d * 0.35, -cell_d * 0.3, cell_t + 2.0]);
let tab = box_from_corners([-3.0, -cell_d * 0.2, cell_t + 1.0], [3.0, cell_d / 2.0 + wall, cell_t + 1.3]);
let cell = cylinder([0, 0, 1.0], "Z", cell_d / 2.0, cell_t).chamfer(0.3, ">Z");
[base + tab, cell]
