// Disc mower cutterbar wear skid: 8 mm plate 200 mm long and 60 mm wide, flat for 150 mm then sweeping up over the front 50 mm to a 30 mm high nose in three straight facets, with two M10 countersunk holes (11 mm through, 20 mm at 90 degrees) 100 mm apart on the flat
let length = 200.0; // [150.0, 280.0] Skid length (mm)
let width = 60.0; // [40.0, 90.0] Skid width (mm)
let thickness = 8.0; // [6.0, 12.0] Plate thickness (mm)
let nose_h = 30.0; // [15.0, 45.0] Nose height (mm)
let hole_pitch = 100.0; // [60.0, 160.0] Bolt hole spacing (mm)
const sweep_len = 50.0;
const hole_d = 11.0;
const csk_d = 20.0;
let t = thickness;
let flat = length - sweep_len;
let profile = polygon([
    [0, 0, 0], [flat, 0, 0], [flat + sweep_len * 0.5, 0, nose_h * 0.2], [flat + sweep_len * 0.85, 0, nose_h * 0.55],
    [length, 0, nose_h], [length - t * 0.7, 0, nose_h + t * 0.7], [flat + sweep_len * 0.85 - t * 0.6, 0, nose_h * 0.55 + t * 0.8],
    [flat + sweep_len * 0.5 - t * 0.25, 0, nose_h * 0.2 + t * 0.97], [flat - t * 0.1, 0, t], [0, 0, t],
]);
let skid = profile.to_face().extrude([0, width, 0]);
let hp = min(hole_pitch, flat - 30.0);
let cutters = [];
for x in [flat / 2.0 - hp / 2.0, flat / 2.0 + hp / 2.0] {
    cutters.push(cylinder([x, width / 2.0, -1.0], "Z", hole_d / 2.0, t + 2.0));
    cutters.push(cone(hole_d / 2.0 - 1.0, csk_d / 2.0 + 1.0, (csk_d - hole_d) / 2.0 + 2.0).translate([x, width / 2.0, t - (csk_d - hole_d) / 2.0 - 1.0]));
}
skid - fuse_all(cutters)
