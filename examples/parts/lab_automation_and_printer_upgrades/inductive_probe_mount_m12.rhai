// Mount for an M12 inductive bed probe (LJ12A3): 30 x 40 mm upright plate 4 mm with 2 x M3 slots 12 mm long for height adjustment, 30 x 26 mm arm 6 mm thick with a 12.4 mm probe hole 16 mm out, side gusset
let probe_d = 12.4; // [8.4, 18.5] Probe hole diameter (mm)
let reach = 16.0; // [12.0, 35.0] Probe centre distance from the plate (mm)
let plate_h = 40.0; // [30.0, 60.0] Upright plate height (mm)
let slot_l = 12.0; // [4.0, 20.0] Adjustment slot length (mm)
const width = 30.0;
const plate_t = 4.0;
const arm_t = 6.0;
let rp = probe_d / 2.0;
let arm_l = max(reach + rp + 4.0, plate_t + probe_d + 4.0);
let r_c = max(reach, plate_t + rp + 2.0);
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, plate_t, plate_h]);
let arm = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, arm_l, arm_t]);
arm = arm.fillet(min(8.0, width / 2.0 - 1.0), arm.edges("|Z and >Y"));
let gusset = polygon([[-width / 2.0, plate_t - 0.5, arm_t - 0.5], [-width / 2.0, plate_t - 0.5, arm_t + 14.0], [-width / 2.0, plate_t + 12.0, arm_t - 0.5]]).to_face().extrude([3.0, 0, 0]);
let mount = fuse_all([plate, arm, gusset]);
let sl = min(slot_l, plate_h - arm_t - 14.0);
let cuts = [cylinder([0, r_c, -1], "Z", rp, arm_t + 2.0)];
for sx in [-1.0, 1.0] {
    let x = sx * 8.0;
    let z0 = plate_h - 7.0 - sl;
    cuts.push(fuse_all([cylinder([x, -1, z0], "Y", 1.7, plate_t + 2.0), cylinder([x, -1, plate_h - 7.0], "Y", 1.7, plate_t + 2.0), box_from_corners([x - 1.7, -1, z0], [x + 1.7, plate_t + 1.0, plate_h - 7.0])]));
}
mount - fuse_all(cuts)
