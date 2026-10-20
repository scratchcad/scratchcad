// Linear shaft support SK16 for a 16 mm rod: 42 mm wide, 14 mm thick, 27 mm centre height, 44 mm tall, two 5.5 mm bolt holes 32 mm apart, slit clamp with M4 screw
let rod = 16.0; // [6.0, 30.0] Rod diameter (mm)
let width = 42.0; // [20.0, 80.0] Width (mm)
let thickness = 14.0; // [8.0, 25.0] Thickness (mm)
let centre_height = 27.0; // [12.0, 50.0] Rod centre height (mm)
let bolt_spacing = 32.0; // [14.0, 66.0] Bolt hole spacing (mm)
const base_h = 8.0;
const bolt_hole = 5.5;
let rr = rod / 2.0;
let top = centre_height + rr + 6.0;
let bs = min(bolt_spacing, width - bolt_hole - 4.0);
let base = box_from_corners([-width / 2.0, -thickness / 2.0, 0], [width / 2.0, thickness / 2.0, base_h]);
let tower = box_from_corners([-rr - 6.0, -thickness / 2.0, base_h - 0.01], [rr + 6.0, thickness / 2.0, top]).fillet(4.0, "|Y and >Z");
let block = base + tower;
block = block - cylinder([0, -thickness, centre_height], "Y", rr, 2.0 * thickness);
block = block - box_from_corners([-0.5, -thickness, centre_height], [0.5, thickness, top + 1.0]);
block = block - cylinder([-rr - 7.0, 0, centre_height + rr + 2.5], "X", 1.7, 2.0 * rr + 14.0);
for s in [-1.0, 1.0] { block = block - cylinder([s * bs / 2.0, 0, -1], "Z", bolt_hole / 2.0, base_h + 2.0); }
block
