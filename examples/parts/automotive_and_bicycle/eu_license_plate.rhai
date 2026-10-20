// EU licence plate blank: 520 x 110 x 1 mm aluminium, 5 mm corners, 1 mm embossed 3 mm border, EU band divider, two 7 mm holes
let w = 520.0; // [300.0, 520.0] Width (mm)
let h = 110.0; // [80.0, 130.0] Height (mm)
let plate = box_centered(w, h, 1.0).fillet(5.0, "|Z");
let border = box_centered(w - 6.0, h - 6.0, 1.0).fillet(4.0, "|Z") - box_centered(w - 12.0, h - 12.0, 3.0).fillet(1.0, "|Z");
let divider = box_centered(1.5, h - 12.0, 1.0).translate([-w / 2.0 + 46.0, 0, 0]);
let p = fuse_all([plate, border.translate([0, 0, 0.9]), divider.translate([0, 0, 0.9])]);
for x in [-130.0, 130.0] { p -= cylinder([x, 0, -2], "Z", 3.5, 5.0); }
p
