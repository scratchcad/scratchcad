// Replacement jaw insert for a super clamp: 40 x 22 mm pad 6 mm thick with a 100 degree V groove 4 mm deep for gripping pipes 13 to 55 mm, 1 x 1 mm cross serrations on 3 mm pitch along both V faces, and a 5 mm dovetail key 3 mm tall on the back
let length = 40.0; // [30.0, 60.0] Jaw length (mm)
let width = 22.0; // [18.0, 30.0] Jaw width (mm)
let v_depth = 4.0; // [2.0, 5.0] V groove depth (mm)
const t = 6.0;
let pad = box_from_corners([-length / 2.0, -width / 2.0, 0], [length / 2.0, width / 2.0, t]);
let half = v_depth * tan(50.0 * PI() / 180.0);
let vee = face(polygon([[-length / 2.0 - 1.0, -half, t + 0.01], [-length / 2.0 - 1.0, 0, t - v_depth], [-length / 2.0 - 1.0, half, t + 0.01]])).extrude([length + 2.0, 0, 0]);
let n = (length / 3.0).to_int() - 1;
let ser = [];
for i in 0..n {
    let x = (i.to_float() - (n.to_float() - 1.0) / 2.0) * 3.0;
    ser.push(box_from_corners([x - 0.5, -width / 2.0 - 1.0, t - 1.0], [x + 0.5, width / 2.0 + 1.0, t + 1.0]));
}
let key = face(polygon([[-length / 2.0, -2.5, 0], [-length / 2.0, 2.5, 0], [-length / 2.0, 3.5, -3.0], [-length / 2.0, -3.5, -3.0]])).extrude([length, 0, 0]);
pad - vee - compound(ser) + key
