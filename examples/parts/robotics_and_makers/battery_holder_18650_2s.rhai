// Two-cell 18650 battery holder (2S series): side-by-side cradles for 18.6 x 65.2 mm cells, 1.5 mm walls, spring and contact slots at both ends, two M3 countersunk mounting holes in the floor
let cell_d = 18.6; // [10.5, 21.5] Cell diameter (mm)
let cell_len = 65.2; // [44.5, 71.0] Cell length (mm)
let cells = 2; // [1, 4] Number of cells
let spring = 5.0; // [3.0, 8.0] Spring allowance per cell (mm)
const wall = 1.5;
let pitch = cell_d + wall;
let inner_l = cell_len + spring;
let length = inner_l + 2.0 * wall + 2.0;
let width = cells.to_float() * pitch + wall;
let height = cell_d * 0.75 + wall;
let b = box_from_corners([0, 0, 0], [length, width, height]).fillet(1.5, "|Z");
for i in 0..cells {
    let y = wall + cell_d / 2.0 + i.to_float() * pitch;
    b -= cylinder([wall + 1.0, y, wall + cell_d / 2.0], "X", cell_d / 2.0 + 0.3, inner_l);
    b -= box_from_corners([wall + 1.0, y - cell_d * 0.35, wall + cell_d / 2.0], [wall + 1.0 + inner_l, y + cell_d * 0.35, height + 1.0]);
    for x in [wall - 0.2, length - wall - 1.0 - 0.6] {
        b -= box_from_corners([x, y - 5.0, wall], [x + 1.2, y + 5.0, height + 1.0]);
        b -= box_from_corners([x - 0.5, y - 1.5, height - 4.0], [x + 2.0, y + 1.5, height + 1.0]);
    }
    if i < cells - 1 { b -= box_from_corners([length - wall - 1.5, y, wall + 2.0], [length - wall - 0.2, y + pitch, height + 1.0]); }
}
for x in [length * 0.3, length * 0.7] {
    b -= cylinder([x, width / 2.0, -1], "Z", 1.6, wall + 2.0) + cone(1.6, 3.2, 1.6).translate([x, width / 2.0, wall - 1.6 + 0.01]);
}
b
