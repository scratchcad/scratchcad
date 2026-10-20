// Robot gripper finger for SBS microplates: 60 x 20 mm mounting flange 5 mm with 2 x M3 counterbored holes on 40 mm, 50 mm drop leg 6 mm thick, 25 mm wide pad with a 90 degree V-groove 2 mm deep that grips the plate skirt
let drop = 50.0; // [30.0, 90.0] Finger drop (mm)
let pad_w = 25.0; // [15.0, 30.0] Pad width (mm)
let t = 6.0; // [4.0, 10.0] Finger thickness (mm)
let hole_pitch = 40.0; // [20.0, 50.0] Mounting hole spacing (mm)
const flange_l = 60.0;
const flange_w = 20.0;
const flange_t = 5.0;
let flange = box_from_corners([-flange_l / 2.0, 0, drop], [flange_l / 2.0, flange_w, drop + flange_t]);
let leg = box_from_corners([-pad_w / 2.0, 0, 0], [pad_w / 2.0, t, drop + 0.5]);
let gusset = polygon([[0, t - 0.5, drop + 0.5], [0, flange_w * 0.8, drop + 0.5], [0, t - 0.5, drop - 12.0]]).to_face().extrude([4.0, 0, 0]).translate([-2.0, 0, 0]);
let finger = fuse_all([flange, leg, gusset]);
let hp = min(hole_pitch, flange_l - 10.0);
let holes = [];
for sx in [-1.0, 1.0] {
    holes.push(cylinder([sx * hp / 2.0, flange_w / 2.0, drop - 1.0], "Z", 1.7, flange_t + 2.0) + cylinder([sx * hp / 2.0, flange_w / 2.0, drop + flange_t - 3.0], "Z", 3.0, 4.0));
}
// V-groove across the pad face, 6 mm above the tip
let vg = polygon([[-pad_w, -1.0, 3.0], [-pad_w, -1.0, 9.0], [-pad_w, 2.0, 6.0]]).to_face().extrude([2.0 * pad_w, 0, 0]);
finger - fuse_all(holes) - vg
