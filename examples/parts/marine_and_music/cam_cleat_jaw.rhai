// Cam cleat for 3 to 12 mm line: 76 x 30 mm base with two 5.5 mm holes 38 mm apart, two sprung toothed cams 25 mm across on 6 mm pins
let base_len = 76.0; // [50.0, 110.0] Base length (mm)
let cam_d = 25.0; // [20.8, 31.0] Cam diameter (mm)
let base = box_centered(base_len, 30.0, 6.0).translate([0, 0, 3.0]).fillet(10.0, "|Z").chamfer(1.0, ">Z");
for x in [-19.0, 19.0] { base -= cylinder([x, 0, -1], "Z", 2.75, 8.0); }
let cams = [];
for s in [-1.0, 1.0] {
    let c = cylinder([0, s * (cam_d / 2.0 + 2.0), 6.0], "Z", cam_d / 2.0, 12.0);
    let teeth = [];
    for k in 0..12 { teeth.push(box_centered(2.0, 3.0, 14.0).translate([0, cam_d / 2.0, 0]).rotate("Z", k.to_float() * 15.0 - 80.0 + if s > 0.0 { 180.0 } else { 0.0 }).translate([0, s * (cam_d / 2.0 + 2.0), 12.0])); }
    cams.push(c - fuse_all(teeth) - cylinder([0, s * (cam_d / 2.0 + 2.0), 5.0], "Z", 3.0, 14.0));
}
compound([base + cylinder([0, cam_d / 2.0 + 2.0, 5.0], "Z", 2.9, 14.0) + cylinder([0, -cam_d / 2.0 - 2.0, 5.0], "Z", 2.9, 14.0)] + cams)
