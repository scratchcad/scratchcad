// Seed drill seed tube funnel: 60 mm cup 40 mm tall narrowing to a 25 mm spigot 30 mm long (for 25 mm bore seed hose) with a barb ring 1 mm proud, 2 mm walls, and two 12 mm mounting ears 3 mm thick with 5.5 mm holes on a 76 mm span at the rim
let mouth_d = 60.0; // [44.0, 90.0] Mouth diameter (mm)
let cone_h = 40.0; // [25.0, 60.0] Cone height (mm)
let spigot_d = 25.0; // [16.0, 35.0] Spigot outside diameter (mm)
let spigot_len = 30.0; // [20.0, 45.0] Spigot length (mm)
const t = 2.0;
const ear_w = 12.0;
const ear_t = 3.0;
let rs = spigot_d / 2.0;
let rm = max(mouth_d / 2.0, rs + 8.0);
let zt = spigot_len + cone_h;
let profile = polygon([
    [rs - t, 0, 0], [rs, 0, 0], [rs, 0, 6.0], [rs + 1.0, 0, 8.0], [rs, 0, 8.0 + 0.5], [rs, 0, spigot_len],
    [rm, 0, zt], [rm - t, 0, zt], [rs - t, 0, spigot_len + 0.8],
]);
let funnel = profile.to_face().revolve("Z", 360.0);
let span = rm + 8.0;
let ears = box_from_corners([-span - ear_w / 2.0, -ear_w / 2.0, zt - ear_t], [span + ear_w / 2.0, ear_w / 2.0, zt]) - box_from_corners([-rm + 1.0, -ear_w, zt - ear_t - 1.0], [rm - 1.0, ear_w, zt + 1.0]);
let ears = ears.fillet(5.0, ears.edges("|Z").filter(|e| e.center().x.abs() > rm + 4.0));
let body = funnel + ears;
body - fuse_all([
    cylinder([-span, 0, zt - ear_t - 1.0], "Z", 2.75, ear_t + 2.0),
    cylinder([span, 0, zt - ear_t - 1.0], "Z", 2.75, ear_t + 2.0),
])
