// Involute spur gear, module 1, 20 teeth, 20 degree pressure angle: 20 mm pitch diameter, 22 mm outside, 8 mm face width, 10 mm hub 6 mm long, 5 mm bore with a 2 mm keyway and M3 set screw
let teeth = 20; // [10, 44] Number of teeth
let module_size = 1.0; // [0.5, 3.0] Module (mm)
let face_w = 8.0; // [3.0, 20.0] Face width (mm)
let bore = 5.0; // [2.0, 12.0] Bore diameter (mm)
let hub_len = 6.0; // [0.0, 15.0] Hub length (mm)
const pa = 20.0;
let z = teeth.to_float();
let m = module_size;
let rp = m * z / 2.0;
let rb = rp * (pa * PI() / 180.0).cos();
let ra = rp + m;
let rf = rp - 1.25 * m;
fn inv(a) { a.tan() - a }
let half_tooth = PI() / (2.0 * z) + inv(pa * PI() / 180.0);
let pts = [];
const steps = 6;
for i in 0..teeth {
    let c = 2.0 * PI() * i.to_float() / z;
    let flank = [];
    for k in 0..=steps {
        let r = max(rb, rf) + (ra - max(rb, rf)) * k.to_float() / steps.to_float();
        let alpha = (rb / r).acos();
        flank.push([r, half_tooth - inv(alpha)]);
    }
    pts.push([rf * (c - half_tooth - 0.02).cos(), rf * (c - half_tooth - 0.02).sin()]);
    for f in flank { pts.push([f[0] * (c - f[1]).cos(), f[0] * (c - f[1]).sin()]); }
    let rev = flank;
    rev.reverse();
    for f in rev { pts.push([f[0] * (c + f[1]).cos(), f[0] * (c + f[1]).sin()]); }
    pts.push([rf * (c + half_tooth + 0.02).cos(), rf * (c + half_tooth + 0.02).sin()]);
}
let gear = polygon(pts).to_face().extrude([0, 0, face_w]);
let bd = min(bore, rf * 2.0 - 4.0);
if hub_len > 0.0 { gear += cylinder([0, 0, face_w - 0.01], "Z", min(bd / 2.0 + 3.0, rf - 1.0), hub_len); }
gear -= cylinder([0, 0, -1], "Z", bd / 2.0, face_w + hub_len + 2.0) + box_from_corners([-1.0, 0, -1], [1.0, bd / 2.0 + 1.0, face_w + hub_len + 1.0]);
if hub_len > 0.0 { gear -= cylinder([0, 0, face_w + hub_len / 2.0], "-Y", 1.25, rf); }
gear
