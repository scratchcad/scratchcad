// Front bracket for an HC-SR04 ultrasonic sensor: 48 x 24 mm face 2.5 mm thick with two 16.5 mm transducer holes 26 mm apart, 20 mm base flange with two M3 slots, side gussets
let face_w = 48.0; // [45.0, 60.0] Face width (mm)
let face_h = 24.0; // [21.0, 30.0] Face height (mm)
let base_d = 20.0; // [12.0, 30.0] Base depth (mm)
let tilt = 0.0; // [-15.0, 15.0] Sensor tilt (degrees)
const t = 2.5;
const spacing = 26.0;
const trans_d = 16.5;
let face = box_from_corners([-face_w / 2.0, -t, 0], [face_w / 2.0, 0, face_h + t]);
let zc = t + face_h / 2.0;
for s in [-1.0, 1.0] { face -= cylinder([s * spacing / 2.0, -t - 1.0, zc], "Y", trans_d / 2.0, t + 2.0); }
face -= box_centered(8.0, 4.0, 4.0).translate([0, -t / 2.0, face_h + t - 2.0]);
face = face.rotate([0, 0, 0], "X", tilt);
let base = box_from_corners([-face_w / 2.0, -0.5, 0], [face_w / 2.0, base_d, t]);
let gussets = [];
for s in [-1.0, 1.0] {
    gussets.push(polygon("YZ", [[-0.5, t - 0.01], [base_d * 0.6, t - 0.01], [-0.5, face_h * 0.6]]).to_face().extrude([2.0, 0, 0]).translate([s * (face_w / 2.0 - 1.0) - 1.0, 0, 0]));
}
let b = fuse_all([face, base] + gussets);
for s in [-1.0, 1.0] {
    let x = s * 12.0;
    b -= box_centered(5.0, 3.4, 10.0).translate([x, base_d * 0.6, 0]) + cylinder([x - 2.5, base_d * 0.6, -1], "Z", 1.7, 6.0) + cylinder([x + 2.5, base_d * 0.6, -1], "Z", 1.7, 6.0);
}
b
