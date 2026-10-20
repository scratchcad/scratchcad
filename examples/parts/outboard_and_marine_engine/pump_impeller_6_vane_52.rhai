// Marine engine raw water pump impeller, 6 vanes: 52 mm over the vane tips, 22 mm wide, 24 mm hub with a 9.5 mm bore and a 1.5 mm deep flat, 3 mm straight vanes with 4 mm round tips, 0.5 mm chamfered hub ends
let tip_d = 52.0; // [36.0, 70.0] Diameter over the vanes (mm)
let width = 22.0; // [12.0, 35.0] Impeller width (mm)
let vanes = 6; // [4, 12] Number of vanes
let shaft_d = 9.5; // [6.0, 16.0] Shaft diameter (mm)
const vane_t = 3.0;
const tip_r = 2.0;
let rh = max(12.0, shaft_d / 2.0 + 5.0);
let hub = cylinder([0, 0, 0], "Z", rh, width);
let hub = hub.chamfer(0.5, hub.edges("%CIRCLE"));
let parts = [hub];
let rt = tip_d / 2.0 - tip_r;
for i in 0..vanes {
    let a = i.to_float() * 360.0 / vanes.to_float();
    let vane = box_from_corners([rh - 1.0, -vane_t / 2.0, 0], [rt, vane_t / 2.0, width]) + cylinder([rt, 0, 0], "Z", tip_r, width);
    parts.push(vane.rotate_z(a));
}
let imp = fuse_all(parts);
let bore = cylinder([0, 0, -1.0], "Z", shaft_d / 2.0, width + 2.0) - box_from_corners([shaft_d / 2.0 - 1.5, -shaft_d, -2.0], [shaft_d, shaft_d, width + 2.0]);
imp - bore
