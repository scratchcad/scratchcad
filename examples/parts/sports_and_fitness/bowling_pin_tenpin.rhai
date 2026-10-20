// Ten-pin bowling pin to USBC dimensions: 381 mm (15 in) tall, 120.7 mm belly at 114 mm, 45.7 mm neck at 254 mm, 64.7 mm head at 343 mm, 50.8 mm base
let height = 381.0; // [300.0, 420.0] Height (mm)
let belly_d = 120.7; // [100.0, 135.0] Belly diameter (mm)
let neck_d = 45.7; // [35.0, 60.0] Neck diameter (mm)
let head_d = 64.7; // [50.0, 75.0] Head diameter (mm)
let base_d = 50.8; // [40.0, 60.0] Base diameter (mm)
let k = height / 381.0;
let pts = [[base_d / 2.0, 0.0], [belly_d * 0.36, 30.0 * k], [belly_d * 0.47, 75.0 * k], [belly_d / 2.0, 114.0 * k], [belly_d * 0.46, 160.0 * k],
    [(belly_d + neck_d) * 0.19, 210.0 * k], [neck_d / 2.0, 254.0 * k], [(neck_d + head_d) * 0.255, 300.0 * k], [head_d / 2.0, 343.0 * k],
    [head_d * 0.36, 367.0 * k], [head_d * 0.17, 378.0 * k], [0.0, height]];
let profile_pts = [];
for p in pts { profile_pts.push([p[0], 0.0, p[1]]); }
let outline = wire([spline(profile_pts), line([0, 0, height], [0, 0, 0]), line([0, 0, 0], [base_d / 2.0, 0, 0])]);
outline.to_face().revolve("Z", 360)
