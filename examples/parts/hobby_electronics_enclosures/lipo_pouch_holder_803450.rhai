// Holder for a 1S LiPo pouch cell 803450 (1500 mAh, 50 x 34 x 8 mm): 1.5 mm floor plate 65 x 37 mm, 4 L-shaped corner clips 9 mm tall with 0.8 mm retaining lips, tab/wire exit gap at one end, 2 x M3 holes, foam-pad grooves
let cell_l = 50.0; // [30.0, 100.0] Cell length (mm)
let cell_w = 34.0; // [20.0, 70.0] Cell width (mm)
let cell_t = 8.0; // [3.0, 15.0] Cell thickness (mm)
let floor_t = 1.5; // [1.2, 3.0] Floor thickness (mm)
let clip_t = 1.4; // [1.0, 2.5] Clip wall thickness (mm)
let lip = 0.8; // [0.4, 1.5] Retaining lip (mm)
let il = cell_l + 0.6;
let iw = cell_w + 0.6;
let ol = il + 2.0 * clip_t;
let ow = iw + 2.0 * clip_t;
let base = box_centered(ol + 12.0, ow, floor_t).translate([0, 0, floor_t / 2.0]);
let base = base.fillet(2.0, base.edges("|Z"));
let parts = [base];
let ch = cell_t + 1.0;
let arm = min(10.0, min(il, iw) * 0.3);
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let cx = sx * (il / 2.0 + clip_t / 2.0);
        let cy = sy * (iw / 2.0 + clip_t / 2.0);
        parts.push(box_centered(clip_t, arm + clip_t, ch + 0.5).translate([cx, cy - sy * arm / 2.0, floor_t + (ch + 0.5) / 2.0 - 0.5]));
        parts.push(box_centered(arm + clip_t, clip_t, ch + 0.5).translate([cx - sx * arm / 2.0, cy, floor_t + (ch + 0.5) / 2.0 - 0.5]));
        let xi = cx - sx * (clip_t / 2.0 + lip);
        let ye = cy - sy * arm;
        parts.push(box_from_corners([min(cx, xi), min(cy, ye), floor_t + ch - 1.0], [max(cx, xi), max(cy, ye), floor_t + ch]));
    }
}
let cuts = [];
for x in [-ol / 2.0 - 3.0, ol / 2.0 + 3.0] {
    cuts.push(cylinder([x, 0, -1], "Z", 1.6, floor_t + 2.0));
}
for y in [-iw / 4.0, iw / 4.0] {
    cuts.push(box_centered(il - 8.0, 1.2, 1.0).translate([0, y, floor_t]));
}
fuse_all(parts) - compound(cuts)
