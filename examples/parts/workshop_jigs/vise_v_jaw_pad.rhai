// Vise soft jaw with V-grooves for a 100 mm vise: 100 x 15 x 30 mm pad, horizontal and vertical 90 degree V-grooves 5 mm deep, hook lip over the jaw, 2 x 12 mm magnet pockets
let jaw_w = 100.0; // [75.0, 150.0] Jaw width (mm)
let height = 30.0; // [20.0, 50.0] Pad height (mm)
let t = 15.0; // [10.0, 20.0] Pad thickness (mm)
let v_depth = 5.0; // [2.0, 7.0] V-groove depth (mm)
let magnet_d = 12.0; // [8.0, 20.0] Magnet pocket diameter (mm)
let pad = box_from_corners([-jaw_w / 2.0, 0, 0], [jaw_w / 2.0, t, height]);
let lip = box_from_corners([-jaw_w / 2.0, -12.0, height - 4.0], [jaw_w / 2.0, 0.01, height]);
let hv = polygon([[-jaw_w / 2.0 - 1.0, t - v_depth, height / 2.0], [-jaw_w / 2.0 - 1.0, t + 1.0, height / 2.0 - v_depth - 1.0], [-jaw_w / 2.0 - 1.0, t + 1.0, height / 2.0 + v_depth + 1.0]]).to_face().extrude([jaw_w + 2.0, 0, 0]);
let vv = polygon([[0, t - v_depth, -1.0], [-v_depth - 1.0, t + 1.0, -1.0], [v_depth + 1.0, t + 1.0, -1.0]]).to_face().extrude([0, 0, height + 2.0]);
let mags = [];
for x in [-jaw_w * 0.3, jaw_w * 0.3] { mags.push(cylinder([x, -1, height * 0.4], "Y", magnet_d / 2.0, 4.0)); }
pad + lip - hv - vv - compound(mags)
