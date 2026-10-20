// Machinist V-block: 60 x 40 x 40 mm, 90 degree V 12 mm deep on top and 6 mm on the bottom, 2 mm relief groove, 10 x 4 mm clamp slots on both sides
let length = 60.0; // [40.0, 100.0] Block length (mm)
let size = 40.0; // [25.0, 60.0] Block width and height (mm)
let v_top = 12.0; // [6.0, 18.0] Top V depth (mm)
let v_bottom = 6.0; // [3.0, 10.0] Bottom V depth (mm)
let blk = box_from_corners([0, 0, 0], [length, size, size]);
let c = size / 2.0;
let vt = polygon([[-1, c - v_top - 1.0, size + 1.0], [-1, c + v_top + 1.0, size + 1.0], [-1, c, size - v_top]]).to_face().extrude([length + 2.0, 0, 0]);
let vb = polygon([[-1, c - v_bottom - 1.0, -1.0], [-1, c, v_bottom], [-1, c + v_bottom + 1.0, -1.0]]).to_face().extrude([length + 2.0, 0, 0]);
let relief = box_from_corners([-1, c - 1.0, size - v_top - 1.5], [length + 1.0, c + 1.0, size - v_top + 0.5]);
let slots = box_from_corners([-1, -1, size * 0.4 - 5.0], [length + 1.0, 4.0, size * 0.4 + 5.0]) + box_from_corners([-1, size - 4.0, size * 0.4 - 5.0], [length + 1.0, size + 1.0, size * 0.4 + 5.0]);
blk.chamfer(0.8) - vt - vb - relief - slots
