// Bucket handle grip for a 4 mm wire bail: 110 mm long, 28 mm grip with 4 finger grooves, 5 mm bore and a 3.4 mm snap-on slot
let length = 110.0; // [80.0, 140.0] Grip length (mm)
let grip_d = 28.0; // [22.0, 36.0] Grip diameter (mm)
let fingers = 4; // [3, 5] Finger grooves
let wire_d = 4.0; // [3.0, 6.0] Wire bail diameter (mm)
let r = grip_d / 2.0;
let pts = [[0, 0], [0, r - 3.0], [6.0, r]];
let span = (length - 24.0) / fingers.to_float();
for i in 0..fingers {
    let x0 = 12.0 + i.to_float() * span;
    pts.push([x0 + span * 0.5, r - 2.0]);
    pts.push([x0 + span, r]);
}
pts.push([length - 6.0, r]);
pts.push([length, r - 3.0]);
pts.push([length, 0]);
let pts3 = pts.map(|p| [p[0], p[1], 0.0]);
let grip = polygon(pts3).to_face().revolve("X", 360);
grip - cylinder([-1, 0, 0], "X", wire_d / 2.0 + 0.5, length + 2.0) - box_from_corners([-1, -wire_d * 0.42, 0], [length + 1.0, wire_d * 0.42, r + 1.0])
