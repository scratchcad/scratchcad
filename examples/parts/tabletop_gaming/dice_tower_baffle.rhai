// Dice tower baffle insert: 70 x 70 mm ramp at 35 degrees, 3 mm plate, 6 mm side tabs for slotted walls
let width = 70.0; // [50.0, 100.0] Tower inner width (mm)
let depth = 70.0; // [50.0, 100.0] Tower inner depth (mm)
let angle = 35.0; // [25.0, 50.0] Ramp angle (degrees)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let len = depth * 0.7 / (angle * PI() / 180.0).cos();
let ramp = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, len, t]).rotate_x(-angle);
let tabs = box_from_corners([-width / 2.0 - 6.0, 10.0, 0], [-width / 2.0 + 0.01, 20.0, t]).rotate_x(-angle) + box_from_corners([width / 2.0 - 0.01, 10.0, 0], [width / 2.0 + 6.0, 20.0, t]).rotate_x(-angle);
let bumps = [];
for k in 0..3 { bumps.push(box_from_corners([-width / 2.0, len * 0.3 + k.to_float() * 10.0, t - 0.01], [width / 2.0, len * 0.3 + k.to_float() * 10.0 + 2.0, t + 1.5]).rotate_x(-angle)); }
ramp + tabs + fuse_all(bumps)
