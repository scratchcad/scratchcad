// 35 mm top-hat DIN rail (EN 60715, 1 mm lips) PCB carrier: 20 mm wide clip with fixed hook and slotted spring latch, 70 x 50 x 2 mm tray on top with 4 standoffs 5 mm for M3 on 62 x 42 mm
let tray_l = 70.0; // [40.0, 120.0] Tray length along the rail (mm)
let tray_w = 50.0; // [40.0, 90.0] Tray width (mm)
let hole_l = 62.0; // [30.0, 110.0] Hole spacing along the rail (mm)
let hole_w = 42.0; // [30.0, 80.0] Hole spacing across (mm)
let standoff = 5.0; // [3.0, 12.0] Standoff height (mm)
let clip_w = 20.0; // [10.0, 40.0] Clip width (mm)
const rail = 35.0;
const lip_t = 1.0;
let half = rail / 2.0;
let cw = min(clip_w, tray_l);
let profile = polygon([
    [0, -half - 3.0, 4.0], [0, -half - 3.0, -lip_t - 1.8], [0, -half + 1.5, -lip_t - 1.8], [0, -half + 1.5, -lip_t - 0.2], [0, -half - 0.3, -lip_t - 0.2], [0, -half - 0.3, 0],
    [0, half + 0.3, 0], [0, half + 0.3, -lip_t - 0.2], [0, half - 1.2, -lip_t - 0.2], [0, half - 1.2, -lip_t - 1.8], [0, half + 3.0, -lip_t - 1.8], [0, half + 3.0, 4.0]
]);
let clip = profile.to_face().extrude([cw, 0, 0]).translate([-cw / 2.0, 0, 0]);
let flex = box_from_corners([-cw / 2.0 - 1.0, half - 8.0, 1.2], [cw / 2.0 + 1.0, half - 6.5, 6.0]);
let tray = box_centered(tray_l, tray_w, 2.0).translate([0, 0, 5.0]);
let tray = tray.fillet(3.0, tray.edges("|Z"));
let parts = [clip, tray];
let drills = [flex];
let hl = min(hole_l, tray_l - 7.0);
let hw = min(hole_w, tray_w - 7.0);
for x in [-hl / 2.0, hl / 2.0] {
    for y in [-hw / 2.0, hw / 2.0] {
        parts.push(cylinder([x, y, 5.5], "Z", 3.0, standoff + 0.5));
        drills.push(cylinder([x, y, 4.0], "Z", 1.25, standoff + 4.0));
    }
}
fuse_all(parts) - compound(drills)
