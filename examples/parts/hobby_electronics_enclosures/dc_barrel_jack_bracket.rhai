// Panel bracket for a PCB-style DC-005 5.5 x 2.1 mm barrel jack (14 x 9 x 11 mm body): 28 x 22 x 2 mm panel plate, 8 mm plug hole, 9.4 x 11.4 mm open-back pocket 13 mm deep with 1.6 mm walls, 2 x M3 holes 22 mm apart
let plate_w = 28.0; // [22.0, 40.0] Plate width (mm)
let plate_h = 22.0; // [16.0, 32.0] Plate height (mm)
let thick = 2.0; // [1.5, 3.5] Plate thickness (mm)
let plug_hole = 8.0; // [6.5, 9.0] Plug hole diameter (mm)
let pocket_depth = 13.0; // [8.0, 16.0] Pocket depth (mm)
let wall = 1.6; // [1.2, 2.5] Pocket wall (mm)
const jack_w = 9.4;
const jack_h = 11.4;
let pw = max(plate_w, jack_w + 2.0 * wall + 9.0);
let plate = box_centered(pw, plate_h, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(2.0, plate.edges("|Z"));
let pocket = box_centered(jack_w + 2.0 * wall, jack_h + 2.0 * wall, pocket_depth).translate([0, 0, thick - 0.5 + pocket_depth / 2.0]);
let body = plate + pocket;
let cavity = box_centered(jack_w, jack_h, pocket_depth * 2.0).translate([0, 0, thick + pocket_depth]);
let hx = pw / 2.0 - 3.5;
body - cavity - cylinder([0, 0, -1], "Z", plug_hole / 2.0, thick + 2.0) - cylinder([-hx, 0, -1], "Z", 1.6, thick + 2.0) - cylinder([hx, 0, -1], "Z", 1.6, thick + 2.0)
