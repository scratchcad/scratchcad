// BK12 fixed-side ball screw support: 60 x 25 x 43 mm, 12 mm bearing seat at 25 mm, 46 mm bolt centers
let width = 60.0; // [45.0, 90.0] Width (mm)
let depth = 25.0; // [20.0, 35.0] Depth (mm)
let height = 43.0; // [32.0, 60.0] Height (mm)
let center_h = 25.0; // [18.0, 35.0] Bearing center height (mm)
let seat_d = 28.0; // [20.0, 40.0] Bearing seat (mm)
let bolt_centers = 46.0; // [34.0, 70.0] Bolt centers (mm)
let block = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
block = block - box_centered(width - 2.0 * 12.0, depth + 2.0, 6.0).translate([0, 0, height + 1.0 - 3.0]);
block = block.fillet(2.0, "|Y and >Z");
block = block - cylinder([0, -depth, center_h], "Y", seat_d / 2.0, depth * 2.0);
for s in [-1, 1] {
    block -= cylinder([s * bolt_centers / 2.0, 0, -1], "Z", 3.3, height + 2.0);
    block -= cylinder([s * bolt_centers / 2.0, 0, height - 6.0], "Z", 5.5, 10.0);
}
block
