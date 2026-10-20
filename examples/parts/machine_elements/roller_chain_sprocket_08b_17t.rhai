// Roller chain sprocket ISO 606 08B (12.7 mm pitch, 8.51 mm rollers), 17 teeth: 69.1 mm pitch diameter, 75.5 mm tip, 7.2 mm tooth width, 45 mm hub 25 mm long, 20 mm bore
let teeth = 17; // [9, 40] Number of teeth
let tooth_width = 7.2; // [4.0, 12.0] Tooth width (mm)
let hub_diameter = 45.0; // [25.0, 80.0] Hub diameter (mm)
let hub_length = 25.0; // [10.0, 50.0] Hub length (mm)
let bore = 20.0; // [8.0, 40.0] Bore diameter (mm)
const pitch = 12.7;
const roller = 8.51;
let n = teeth.to_float();
let half = PI() / n;
let rp = pitch / half.sin() / 2.0;
let rt = pitch * (0.6 + half.cos() / half.sin()) / 2.0;
let seat = 0.505 * roller + 0.069 * roller ** (1.0 / 3.0);
let flank = (32.0 * PI() / 180.0).tan();
let outer = rt + 1.0;
let gaps = [];
for i in 0..teeth {
    let a = (i.to_float() + 0.5) * 360.0 / n;
    let w_out = seat + (outer - rp) * flank;
    let wedge = polygon([[rp, -seat, -1], [outer, -w_out, -1], [outer, w_out, -1], [rp, seat, -1]]).to_face().extrude(tooth_width + 2.0);
    gaps.push(cylinder([rp, 0, -1], "Z", seat, tooth_width + 2.0).rotate("Z", a));
    gaps.push(wedge.rotate("Z", a));
}
let plate = cylinder(rt, tooth_width) - fuse_all(gaps);
plate = plate.chamfer(0.6, "%CIRCLE and (>Z or <Z)");
let rh = min(max(hub_diameter / 2.0, bore / 2.0 + 4.0), rp - seat - 3.0);
let hub = cylinder([0, 0, tooth_width - 0.01], "Z", rh, hub_length - tooth_width + 0.01);
let part = plate + hub;
let key = box_from_corners([-3.0, 0, -1], [3.0, bore / 2.0 + 2.8, hub_length + 1.0]);
part = part - fuse_all([cylinder([0, 0, -1], "Z", bore / 2.0, hub_length + 2.0), key]);
print(`pitch diameter ${2.0 * rp}, tip diameter ${2.0 * rt}`);
part - cylinder([0, 0, (hub_length + tooth_width) / 2.0], "X", 2.5, rh + 1.0)
