// Fire extinguisher wall bracket for 2 kg units: 110 mm cradle for a 110 mm cylinder, 40 mm wide 3 mm strap, 2 keyholes
let cyl = 110.0; // [80.0, 160.0] Extinguisher diameter (mm)
let width = 40.0; // [25.0, 60.0] Strap width (mm)
let t = 3.0; // [2.0, 5.0] Strap thickness (mm)
let r = cyl / 2.0;
let cradle = (cylinder([0, r + t, 0], "Z", r + t, width) - cylinder([0, r + t, -1], "Z", r, width + 2.0)) & box_from_corners([-r - t - 1.0, -1, -1], [r + t + 1.0, r + t, width + 1.0]);
let plate = box_from_corners([-30.0, -t, -30.0], [30.0, 0.01, width + 30.0]);
let keys = [];
for z in [-18.0, width + 18.0] { keys.push(cylinder([0, -t - 1.0, z], "Y", 4.0, t + 2.0) + box_from_corners([-2.0, -t - 1.0, z], [2.0, 1.0, z + 7.0])); }
cradle + plate - fuse_all(keys)
