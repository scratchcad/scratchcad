// Four-cell AA battery box (6 V): 4 side-by-side 14.5 x 50.5 mm cells, 1.2 mm walls, coil-spring pockets, lead exit notch and a 2 mm lid ledge
let cell_d = 14.5; // [10.0, 18.0] Cell diameter (mm)
let cell_len = 50.5; // [44.0, 65.0] Cell length (mm)
let cells = 4; // [1, 8] Number of cells
const wall = 1.2;
const spring = 4.0;
let pitch = cell_d + 0.5;
let inner_l = cell_len + spring;
let length = inner_l + 2.0 * wall + 2.0;
let width = cells.to_float() * pitch + 2.0 * wall;
let height = cell_d + wall + 1.0;
let b = box_from_corners([0, 0, 0], [length, width, height]).fillet(2.0, "|Z") - box_from_corners([wall, wall, wall], [length - wall, width - wall, height + 1.0]).fillet(1.0, "|Z");
let ribs = [];
for i in 0..cells {
    let y = wall + pitch * (i.to_float() + 0.5);
    let cradle = box_from_corners([wall + 1.0, y - pitch / 2.0 - 0.01, wall - 0.01], [length - wall - 1.0, y + pitch / 2.0 + 0.01, wall + cell_d * 0.3]) - cylinder([0, y, wall + cell_d / 2.0], "X", cell_d / 2.0 + 0.2, length);
    ribs.push(cradle);
    for x in [wall + 1.0, length - wall - 2.0] { ribs.push(box_from_corners([x, y - 4.0, wall - 0.01], [x + 1.0, y - 2.0, height - 2.0])); ribs.push(box_from_corners([x, y + 2.0, wall - 0.01], [x + 1.0, y + 4.0, height - 2.0])); }
}
b = fuse_all([b] + ribs);
b -= box_from_corners([length - wall - 1.0, width / 2.0 - 2.0, height - 4.0], [length + 1.0, width / 2.0 + 2.0, height + 1.0]);
b - (box_from_corners([wall / 2.0, wall / 2.0, height - 2.0], [length - wall / 2.0, width - wall / 2.0, height + 1.0]) - box_from_corners([wall * 1.5, wall * 1.5, height - 3.0], [length - wall * 1.5, width - wall * 1.5, height + 2.0]))
