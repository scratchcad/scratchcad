// ESP32 DevKit V1 (30-pin, 51.5 x 28.3 mm board) snap mount: 61 x 38 x 2 mm base, two 6 mm side rails with 0.8 mm snap lips over a 1.6 mm PCB at 5 mm height, open USB end, 2 x M3 holes 50 mm apart
let board_l = 51.5; // [40.0, 60.0] Board length (mm)
let board_w = 28.3; // [20.0, 32.0] Board width (mm)
let height = 5.0; // [3.0, 10.0] Board height above base (mm)
let base_t = 2.0; // [1.5, 3.0] Base thickness (mm)
let rail_t = 1.6; // [1.2, 2.5] Rail thickness (mm)
let lip = 0.8; // [0.4, 1.2] Snap lip overhang (mm)
const pcb = 1.6;
let len = board_l + 10.0;
let wid = board_w + 2.0 * rail_t + 6.0;
let base = box_centered(len, wid, base_t).translate([0, 0, base_t / 2.0]);
let base = base.fillet(3.0, base.edges("|Z"));
let parts = [base];
let top = base_t + height + pcb;
for s in [-1.0, 1.0] {
    let yi = s * (board_w / 2.0 + 0.15);
    let yo = s * (board_w / 2.0 + 0.15 + rail_t);
    parts.push(box_from_corners([-board_l / 2.0 + 4.0, min(yi, yo), base_t - 0.5], [board_l / 2.0 - 4.0, max(yi, yo), top + 1.5]));
    parts.push(polygon([[-board_l / 2.0 + 4.0, yi, top], [-board_l / 2.0 + 4.0, yi - s * lip, top + 0.4], [-board_l / 2.0 + 4.0, yi, top + 1.5]]).to_face().extrude([board_l - 8.0, 0, 0]));
    parts.push(box_from_corners([-board_l / 2.0 + 2.0, min(yi, yi - s * 2.5), base_t - 0.5], [board_l / 2.0 - 2.0, max(yi, yi - s * 2.5), base_t + height]));
}
let cuts = [cylinder([-len / 2.0 + 3.5, 0, -1], "Z", 1.6, base_t + 2.0), cylinder([len / 2.0 - 3.5, 0, -1], "Z", 1.6, base_t + 2.0)];
cuts.push(box_from_corners([-board_l / 2.0 + 8.0, -board_w / 2.0 + 6.0, -1], [board_l / 2.0 - 8.0, board_w / 2.0 - 6.0, base_t + 1.0]));
fuse_all(parts) - compound(cuts)
