// NEMA 17 L-bracket for 2020 extrusion
let thickness = 3.0; // [2.0, 6.0] Plate thickness (mm)
let width = 42.3; // [42.3, 50.0] Bracket width (mm)
let base_length = 40.0; // [25.0, 60.0] Base length (mm)
let slot_d = 5.2; // [4.0, 6.5] Base slot width (mm)
let w = width; let t = thickness;
let face = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, t, w + t]);
let base = box_from_corners([-w / 2.0, 0, 0], [w / 2.0, base_length + t, t]);
let gussets = [];
for s in [-1, 1] {
    let x = s * (w / 2.0 - t / 2.0);
    gussets.push(polygon([[x - t / 2.0, t - 0.1, t - 0.1], [x - t / 2.0, base_length * 0.7, t - 0.1], [x - t / 2.0, t - 0.1, w * 0.7]]).to_face().extrude([t, 0, 0]));
}
let part = fuse_all([face, base] + gussets);
let cz = t + w / 2.0;
part -= cylinder([0, -1, cz], "Y", 11.5, t + 2.0);
for sx in [-1, 1] { for sz in [-1, 1] { part -= cylinder([sx * 15.5, -1, cz + sz * 15.5], "Y", 1.7, t + 2.0); } }
for y in [t + base_length * 0.35, t + base_length * 0.8] {
    let slot = cylinder([-6, y, -1], "Z", slot_d / 2.0, t + 2.0) + cylinder([6, y, -1], "Z", slot_d / 2.0, t + 2.0) + box_centered(12, slot_d, t + 2.0).translate([0, y, t / 2.0]);
    part -= slot;
}
part.fillet(0.8, "|X and >Y")
