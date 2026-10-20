// Single servo arm for a 25T spline: 9 mm hub 5.5 mm tall, 20 mm tapered arm 2 mm thick with seven 1.5 mm holes
let len = 20.0; // [12.0, 35.0] Arm length (mm)
const r1 = 4.5;
const r2 = 2.0;
let c = (r1 - r2) / len;
let s = sqrt(1.0 - c * c);
let arm = sketch().move_to(r1 * c, -r1 * s).line_to(len + r2 * c, -r2 * s).arc_to(len + r2, 0, len + r2 * c, r2 * s).line_to(r1 * c, r1 * s).arc_to(-r1, 0, r1 * c, -r1 * s).close().to_face().extrude(2.0);
let horn = arm + cylinder(r1, 5.5);
let holes = [cylinder([0, 0, -1], "Z", 1.2, 8.0), cylinder([0, 0, -1], "Z", 2.95, 5.0)];
let k = 0;
while 8.0 + k.to_float() * 2.0 <= len { holes.push(cylinder([8.0 + k.to_float() * 2.0, 0, -1], "Z", 0.75, 4.0)); k += 1; }
horn - fuse_all(holes)
