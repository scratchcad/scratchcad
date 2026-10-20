// Bed footboard chart holder clip: U-clip over a 30 mm footboard, 40 mm wide with 45 mm legs 4 mm thick, and a 12 mm deep front ledge with an 8 mm lip that holds an A4 clipboard
let board = 30.0; // [18.0, 45.0] Footboard thickness (mm)
let width = 40.0; // [25.0, 60.0] Clip width (mm)
let leg = 45.0; // [30.0, 60.0] Leg length (mm)
let ledge = 12.0; // [8.0, 20.0] Clipboard ledge depth (mm)
const t = 4.0;
let c = fuse_all([
    box_from_corners([0, -t, -leg], [width, 0, t]),
    box_from_corners([0, -t, 0], [width, board + t, t]),
    box_from_corners([0, board, -leg * 0.6], [width, board + t, t]),
    box_from_corners([0, -t - ledge, -leg], [width, -t + 0.01, -leg + t]),
    box_from_corners([0, -t - ledge, -leg], [width, -t - ledge + 3.0, -leg + t + 8.0]),
]);
c - box_from_corners([-1.0, board - 0.01, -leg * 0.6 - 1.0], [width + 1.0, board + 1.5, -leg * 0.6 + 4.0]) + box_from_corners([0, board - 1.5, -leg * 0.6], [width, board + 0.01, -leg * 0.6 + 4.0])
