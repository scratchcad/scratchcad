// Three-way spoke wrench: 28 mm rounded square 4 mm thick, 3.23 / 3.30 / 3.45 mm slots on three sides, 6 mm key-ring hole
let s = 28.0; // [22.0, 40.0] Size (mm)
let w = box_centered(s, s, 4.0).fillet(6.0, "|Z");
let i = 0;
for gap in [3.23, 3.30, 3.45] {
    w -= (box_from_corners([-gap / 2.0, 3.0, -3.0], [gap / 2.0, s, 3.0]) + box_from_corners([-gap / 2.0 - 0.6, 6.0, -3.0], [gap / 2.0 + 0.6, 8.0, 3.0])).rotate("Z", i.to_float() * 90.0);
    i += 1;
}
w - cylinder([0, -s / 2.0 + 6.0, -3.0], "Z", 3.0, 6.0)
