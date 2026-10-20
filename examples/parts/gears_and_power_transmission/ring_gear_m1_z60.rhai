// Internal ring gear module 1, 60 teeth, 8 mm face, 70 mm OD, with 6 mounting holes on a 66 mm circle
let gear_module = 1.0; // [0.5, 2.0] Module (mm)
let teeth = 60; // [40, 120] Number of teeth
let face = 8.0; // [4.0, 20.0] Face width (mm)
let outer_d = 72.0; // [60.0, 140.0] Outside diameter (mm)
// One involute tooth outline (closed polygon in XY), centred on +X, for a gear of `teeth` teeth.
fn tooth(m, teeth, pa, backlash) {
    let rp = m * teeth.to_float() / 2.0;
    let rb = rp * (pa * PI() / 180.0).cos();
    let ra = rp + m;
    let rf = max(rp - 1.25 * m, 0.5);
    let tmax = ((ra * ra - rb * rb).sqrt()) / rb;
    let tp = ((rp * rp - rb * rb).sqrt()) / rb;
    let half = PI() / (2.0 * teeth.to_float()) - backlash / (2.0 * rp);
    let rot = half + tp - tp.atan();
    let flank = [];
    for i in 0..=8 {
        let t = tmax * i.to_float() / 8.0;
        let x = rb * (t.cos() + t * t.sin());
        let y = rb * (t.sin() - t * t.cos());
        let a = y.atan(x) - rot;
        let r = (x * x + y * y).sqrt();
        flank.push([r * a.cos(), r * a.sin()]);
    }
    let a0 = flank[0][1].atan(flank[0][0]);
    let r0 = min(rf, rb) - 0.01;
    let pts = [[r0 * a0.cos(), r0 * a0.sin()]];
    for p in flank { pts.push(p); }
    let upper = [];
    for p in flank { upper.push([p[0], -p[1]]); }
    upper.reverse();
    for p in upper { pts.push(p); }
    pts.push([r0 * a0.cos(), -r0 * a0.sin()]);
    pts
}
fn gear_blank(m, teeth, pa, width) {
    let rf = max(m * teeth.to_float() / 2.0 - 1.25 * m, 0.5);
    let rb = m * teeth.to_float() / 2.0 * (pa * PI() / 180.0).cos();
    let t = polygon(tooth(m, teeth, pa, 0.0)).to_face().extrude(width);
    let all = [cylinder(min(rf, rb) + 0.02, width)];
    for i in 0..teeth { all.push(t.rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
    fuse_all(all)
}
let rp = gear_module * teeth.to_float() / 2.0;
// an internal gear's teeth are the spaces of an external gear with the same pitch circle
let cutter = gear_blank(gear_module, teeth, 20.0, face + 2.0).translate([0, 0, -1]).rotate_z(180.0 / teeth.to_float());
let ring = cylinder(outer_d / 2.0, face) - cutter - cylinder([0, 0, -1], "Z", rp - gear_module, face + 2.0);
for i in 0..6 { ring -= cylinder([outer_d / 2.0 - 3.0, 0, -1], "Z", 1.1, face + 2.0).rotate_z(i * 60); }
ring
