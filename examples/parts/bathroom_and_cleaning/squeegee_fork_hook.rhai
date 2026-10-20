// Shower squeegee fork hook: 40 x 50 x 3 mm adhesive plate, two 25 mm fingers 6 mm wide with 5 mm up-lips, 14 mm slot for a squeegee handle
let slot = 14.0; // [8.0, 24.0] Slot width (mm)
let reach = 25.0; // [15.0, 40.0] Finger length (mm)
let finger_w = 6.0; // [4.0, 10.0] Finger width (mm)
let lip = 5.0; // [2.0, 10.0] Lip height (mm)
let t = 3.0; // [2.0, 5.0] Thickness (mm)
let pw = slot + 2.0 * finger_w + 10.0;
let plate = box_from_corners([-pw / 2.0, 0, 0], [pw / 2.0, t, 50.0]);
let p = plate.fillet(4.0, plate.edges("|Y"));
let parts = [p];
for s in [-1.0, 1.0] {
    let x0 = s * (slot / 2.0 + finger_w / 2.0);
    parts.push(box_from_corners([x0 - finger_w / 2.0, t - 0.5, 10.0], [x0 + finger_w / 2.0, t + reach, 10.0 + t]));
    parts.push(box_from_corners([x0 - finger_w / 2.0, t + reach - t, 10.0 + t - 0.5], [x0 + finger_w / 2.0, t + reach, 10.0 + t + lip]));
    parts.push(polygon([[x0 - t / 2.0, t - 0.5, 10.0 + t - 0.5], [x0 - t / 2.0, t + 10.0, 10.0 + t - 0.5], [x0 - t / 2.0, t - 0.5, 26.0]]).to_face().extrude([t, 0, 0]));
}
fuse_all(parts)
