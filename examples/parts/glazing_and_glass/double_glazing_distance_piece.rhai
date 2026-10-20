// Double glazing distance piece: U-shaped 2 mm spacer clip that holds a 16 mm gap between two 4 mm panes, 10 mm wide, 12 mm tall legs
let gap = 16.0; // [6.0, 24.0] Air gap (mm)
let pane = 4.0; // [3.0, 10.0] Pane thickness (mm)
const t = 2.0;
const w = 10.0;
let core = box_from_corners([pane, 0, 0], [pane + gap, w, 12.0]);
let outer = box_from_corners([-t, 0, 0], [2.0 * pane + gap + t, w, t]) + box_from_corners([-t, 0, 0], [0, w, 12.0]) + box_from_corners([2.0 * pane + gap, 0, 0], [2.0 * pane + gap + t, w, 12.0]);
core + outer - box_from_corners([pane + 2.0, -1.0, 2.0], [pane + gap - 2.0, w + 1.0, 13.0])
