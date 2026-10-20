// 12-channel reagent reservoir on the SBS footprint: 127.76 x 85.48 x 48 mm, 12 troughs 8 mm wide at 9 mm pitch aligned to plate columns (A1 at 14.38 mm), 40 mm deep with 4 mm V-bottoms, 1 mm dividers, 4 mm solid base under the V
let channels = 12; // [1, 12] Number of troughs
let depth = 40.0; // [20.0, 40.0] Trough depth (mm)
let v_depth = 4.0; // [2.0, 6.0] V-bottom depth (mm)
const sbs_l = 127.76;
const sbs_w = 85.48;
const pitch = 9.0;
const trough_w = 8.0;
const trough_y = 72.0;
let height = depth + v_depth + 4.0;
let res = box_from_corners([0, 0, 0], [sbs_l, sbs_w, height]);
res = res.fillet(3.0, "|Z");
let floor_z = height - depth;
let cuts = [];
for i in 0..channels {
    let x = 14.38 + i.to_float() * pitch;
    let y0 = (sbs_w - trough_y) / 2.0;
    cuts.push(box_from_corners([x - trough_w / 2.0, y0, floor_z], [x + trough_w / 2.0, y0 + trough_y, height + 1.0]));
    // V-bottom: a prism with its ridge pointing down along the trough
    cuts.push(polygon([[x - trough_w / 2.0, y0, floor_z + 0.5], [x + trough_w / 2.0, y0, floor_z + 0.5], [x, y0, floor_z - v_depth]]).to_face().extrude([0, trough_y, 0]));
}
res - fuse_all(cuts)
