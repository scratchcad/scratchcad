// Straight gear rack, module 1, 20 degree pressure angle: 100 mm long, 10 mm face width, 10 mm tall to the pitch line, 3.14 mm circular pitch, two M3 countersunk mounting holes
let length = 100.0; // [30.0, 300.0] Rack length (mm)
let module_size = 1.0; // [0.5, 3.0] Module (mm)
let face_w = 10.0; // [5.0, 25.0] Face width (mm)
let pitch_h = 10.0; // [5.0, 25.0] Height to the pitch line (mm)
const pa = 20.0;
let m = module_size;
let p = PI() * m;
let n = (length / p).floor().to_int();
let tn = (pa * PI() / 180.0).tan();
let base = pitch_h - 1.25 * m;
let pts = [[0, 0], [n.to_float() * p, 0]];
pts.push([n.to_float() * p, base]);
let k = n - 1;
while k >= 0 {
    let x0 = k.to_float() * p;
    let xa = x0 + p / 4.0 - 1.25 * m * tn;
    pts += [[x0 + p - p / 4.0 + 1.25 * m * tn, base], [x0 + p - p / 4.0 - m * tn + 0.0, pitch_h + m]];
    pts += [[x0 + p / 4.0 + m * tn, pitch_h + m]];
    pts += [[xa, base]];
    k -= 1;
}
let r = polygon("XZ", pts).to_face().extrude([0, face_w, 0]);
for x in [n.to_float() * p * 0.2, n.to_float() * p * 0.8] {
    r -= cylinder([x, face_w / 2.0, -1], "Z", 1.6, base + 2.0) + cylinder([x, face_w / 2.0, base - 3.0], "Z", 3.0, 10.0);
}
r
