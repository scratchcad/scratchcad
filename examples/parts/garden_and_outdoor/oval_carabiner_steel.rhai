// Oval steel carabiner: 108 x 60 mm, 10 mm rod, straight wire-less gate leaving a 20 mm opening when pressed
let length = 108.0; // [70.0, 140.0] Overall length (mm)
let width = 60.0; // [40.0, 80.0] Overall width (mm)
let rod = 10.0; // [6.0, 13.0] Rod diameter (mm)
let gate_rod = 8.0; // [5.0, 11.0] Gate rod diameter (mm)
let r = rod / 2.0;
let R = (width - rod) / 2.0;
let straight = max(length - rod - 2.0 * R, 10.0);
let y0 = R;
let y1 = R + straight;
let path = wire([line([0, y0, 0], [0, y1, 0]), arc([0, y1, 0], [R, y1 + R, 0], [2.0 * R, y1, 0]),
                 line([2.0 * R, y1, 0], [2.0 * R, y0, 0]), arc([2.0 * R, y0, 0], [R, 0, 0], [0, y0, 0])]);
let frame = circle([0, y0, 0], [0, 1, 0], r).to_face().sweep(path);
let g0 = y0 + 3.0;
let g1 = y1 - 3.0;
frame -= box_from_corners([2.0 * R - rod, g0, -rod], [2.0 * R + rod, g1, rod]);
let gate = cylinder([2.0 * R, g0 + 0.6, 0], "Y", gate_rod / 2.0, g1 - g0 - 1.2);
compound([frame, gate])
