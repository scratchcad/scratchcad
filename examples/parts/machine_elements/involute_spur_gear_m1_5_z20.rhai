// Involute spur gear, module 1.5, 20 teeth, 20 deg pressure angle: 30 mm pitch, 33 mm tip, 26.25 mm root diameter, 10 mm face width, 8 mm bore
let gear_module = 1.5; // [0.5, 4.0] Module (mm)
let teeth = 20; // [12, 80] Number of teeth
let face_width = 10.0; // [3.0, 40.0] Face width (mm)
let bore = 8.0; // [2.0, 30.0] Bore diameter (mm)
const pressure_angle = 20.0;
const flank_points = 8;
let z = teeth.to_float();
let pa = pressure_angle * PI() / 180.0;
let rp = gear_module * z / 2.0;
let rb = rp * pa.cos();
let ra = rp + gear_module;
let rf = rp - 1.25 * gear_module;
let inv_pa = pa.tan() - pa;
let half = PI() / (2.0 * z) + inv_pa;
let tmax = ((ra / rb) * (ra / rb) - 1.0).sqrt();
let r0 = max(rb, rf);
let tmin = if rf < rb { 0.0 } else { ((rf / rb) * (rf / rb) - 1.0).sqrt() };
let pts = [];
for k in 0..teeth {
    let c = 2.0 * PI() * k.to_float() / z;
    let lower = [];
    for j in 0..=flank_points {
        let t = tmin + (tmax - tmin) * j.to_float() / flank_points.to_float();
        let r = rb * (1.0 + t * t).sqrt();
        let th = t - t.atan();
        lower.push([r, half - th]);
    }
    if rf < rb { pts.push([rf * (c - half).cos(), rf * (c - half).sin()]); }
    for p in lower { let a = c - p[1]; pts.push([p[0] * a.cos(), p[0] * a.sin()]); }
    let n = lower.len();
    for j in 0..n { let p = lower[n - 1 - j]; let a = c + p[1]; pts.push([p[0] * a.cos(), p[0] * a.sin()]); }
    if rf < rb { pts.push([rf * (c + half).cos(), rf * (c + half).sin()]); }
}
let gear = polygon(pts).to_face().extrude(face_width);
let b = min(bore, rf * 1.2);
print(`pitch ${2.0 * rp} tip ${2.0 * ra} root ${2.0 * rf} base ${2.0 * rb}`);
gear - cylinder([0, 0, -1], "Z", b / 2.0, face_width + 2.0)
