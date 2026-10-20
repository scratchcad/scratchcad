// Seed hopper sight window frame: 5 mm bezel 128 x 88 mm (14 mm border) with 6 mm rounded corners around a 100 x 60 mm sight opening, a rebate 3.2 mm deep and 5 mm wide behind the opening for a 3 mm polycarbonate pane, and six 5.5 mm holes for M5 screws in the border outside the rebate, at the corners and mid-way along the long sides
let open_w = 100.0; // [60.0, 160.0] Opening width (mm)
let open_h = 60.0; // [40.0, 120.0] Opening height (mm)
let border = 14.0; // [13.0, 22.0] Border width (mm)
let pane_t = 3.2; // [2.2, 4.2] Pane rebate depth (mm)
const t = 5.0;
const rebate = 5.0;
const hole_d = 5.5;
let ow = open_w + 2.0 * border;
let oh = open_h + 2.0 * border;
let frame = box_from_corners([-ow / 2.0, -oh / 2.0, 0], [ow / 2.0, oh / 2.0, t]);
let frame = frame.fillet(6.0, frame.edges("|Z"));
let rw = open_w + 2.0 * rebate;
let rh = open_h + 2.0 * rebate;
let cutters = [
    box_from_corners([-open_w / 2.0, -open_h / 2.0, -1.0], [open_w / 2.0, open_h / 2.0, t + 1.0]),
    box_from_corners([-rw / 2.0, -rh / 2.0, -1.0], [rw / 2.0, rh / 2.0, min(pane_t, t - 1.5)]),
];
let hx = open_w / 2.0 + (rebate + border) / 2.0;
let hy = open_h / 2.0 + (rebate + border) / 2.0;
for p in [[-hx, -hy], [0.0, -hy], [hx, -hy], [-hx, hy], [0.0, hy], [hx, hy]] {
    cutters.push(cylinder([p[0], p[1], -1.0], "Z", hole_d / 2.0, t + 2.0));
}
frame - fuse_all(cutters)
