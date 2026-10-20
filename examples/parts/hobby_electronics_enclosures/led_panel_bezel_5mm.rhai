// Panel-mount bezel for a 5 mm LED in an 8 mm hole, 1 to 3 mm panel: 10 mm front flange 1.5 mm with chamfer, 5.1 mm LED bore with 5.9 mm rim seat, 7.9 mm shank 7 mm long split into 4 fingers with 0.4 mm snap ridge
let led = 5.0; // [3.0, 10.0] LED diameter (mm)
let panel_hole = 8.0; // [5.0, 14.0] Panel hole diameter (mm)
let flange_d = 10.0; // [7.0, 18.0] Flange diameter (mm)
let panel_t = 2.0; // [0.8, 3.5] Panel thickness (mm)
let shank = 7.0; // [6.0, 12.0] Shank length (mm)
let fingers = 4; // [2, 6] Number of split fingers
let rl = led / 2.0 + 0.05;
let rh = max(panel_hole / 2.0 - 0.05, rl + 0.8);
let rf = max(flange_d / 2.0, rh + 1.0);
const ft = 1.5;
let ridge_z = ft + panel_t + 0.1;
let pts = [[rl, 0, 0], [rf - 0.5, 0, 0], [rf, 0, 0.5], [rf, 0, ft], [rh, 0, ft], [rh, 0, ridge_z], [rh + 0.4, 0, ridge_z + 0.3], [rh, 0, min(ridge_z + 1.5, ft + shank)], [rh, 0, ft + shank], [rl, 0, ft + shank]];
let body = polygon(pts).to_face().revolve("Z", 360);
let seat = cylinder([0, 0, ft + shank - 1.2], "Z", min(rl + 0.45, rh - 0.35), 2.0);
let cuts = [seat];
for k in 0..fingers {
    cuts.push(box_from_corners([0, -0.5, ft + 1.0], [rf + 1.0, 0.5, ft + shank + 1.0]).rotate_z(k.to_float() * 360.0 / fingers.to_float()));
}
body - fuse_all(cuts)
