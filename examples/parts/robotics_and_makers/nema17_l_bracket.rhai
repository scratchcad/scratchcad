// NEMA 17 stepper motor L bracket: 4 mm steel, 42.3 mm motor face with 22.5 mm pilot hole and four M3 holes on a 31 mm square, 40 mm base with two M5 slots, triangular gussets
let face = 44.0; // [42.3, 60.0] Face plate size (mm)
let base = 40.0; // [25.0, 60.0] Base depth (mm)
let t = 4.0; // [2.0, 6.0] Plate thickness (mm)
let pilot_d = 22.5; // [16.0, 28.0] Pilot hole diameter (mm)
const pattern = 31.0;
let hf = face / 2.0;
let plate = box_from_corners([-hf, 0, 0], [hf, t, face + t]);
let zc = t + face / 2.0;
plate -= cylinder([0, -1, zc], "Y", pilot_d / 2.0, t + 2.0);
for x in [-1.0, 1.0] { for z in [-1.0, 1.0] { plate -= cylinder([x * pattern / 2.0, -1, zc + z * pattern / 2.0], "Y", 1.7, t + 2.0); } }
let b = box_from_corners([-hf, 0, 0], [hf, base + t, t]);
let gussets = [];
for s in [-1.0, 1.0] {
    gussets.push(polygon("YZ", [[t - 0.01, t - 0.01], [base + t - 4.0, t - 0.01], [t - 0.01, face * 0.8]]).to_face().extrude([t, 0, 0]).translate([s * (hf - t / 2.0) - t / 2.0, 0, 0]));
}
let br = fuse_all([plate, b] + gussets);
for s in [-1.0, 1.0] {
    let x = s * hf * 0.45;
    br -= box_centered(5.5, 8.0, 10.0).translate([x, t + base * 0.6, 0]) + cylinder([x, t + base * 0.6 - 4.0, -1], "Z", 2.75, t + 2.0) + cylinder([x, t + base * 0.6 + 4.0, -1], "Z", 2.75, t + 2.0);
}
br.fillet(2.0, "|Y and >Z").fillet(2.0, "|Z and >Y")
