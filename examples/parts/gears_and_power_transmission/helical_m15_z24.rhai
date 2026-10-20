// Helical gear module 1.5 (transverse), 24 teeth, 20 deg helix, 12 mm face, 8 mm bore
let gear_module = 1.5; // [0.5, 3.0] Module (mm)
let teeth = 24; // [10, 60] Number of teeth
let face = 12.0; // [5.0, 30.0] Face width (mm)
let helix = 20.0; // [0.0, 35.0] Helix angle (degrees)
let bore = 8.0; // [3.0, 20.0] Bore (mm)
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
let twist = face * (helix * PI() / 180.0).tan() / rp * 180.0 / PI();
let outline = [];
for i in 0..teeth {
    let a = i.to_float() * 360.0 / teeth.to_float() * PI() / 180.0;
    for p in tooth(gear_module, teeth, 20.0, 0.0) { outline.push([p[0] * a.cos() - p[1] * a.sin(), p[0] * a.sin() + p[1] * a.cos()]); }
}
let base = polygon(outline);
let sections = [];
for k in 0..=6 { let f = k.to_float() / 6.0; sections.push(base.rotate_z(twist * f).translate([0, 0, face * f])); }
loft(sections, true) - cylinder([0, 0, -1], "Z", bore / 2.0, face + 2.0)
