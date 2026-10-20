// Straight bevel gear module 2, 20 teeth, 90 deg shaft angle with a 20-tooth mate (45 deg pitch cone), 10 mm face
let gear_module = 2.0; // [1.0, 4.0] Module (mm)
let teeth = 20; // [12, 40] Number of teeth
let face = 10.0; // [5.0, 20.0] Face width (mm)
let bore = 10.0; // [4.0, 20.0] Bore (mm)
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
let cone_angle = 45.0;
let rp = gear_module * teeth.to_float() / 2.0;
let cone_len = rp / (cone_angle * PI() / 180.0).sin();
let scale_in = (cone_len - face) / cone_len;
let outer = polygon(tooth(gear_module, teeth, 20.0, 0.0));
let inner = outer.scale(scale_in).translate([0, 0, face * (cone_angle * PI() / 180.0).cos()]);
let t = loft([outer, inner], true);
let core_r = rp - 1.25 * gear_module;
let parts = [cone(core_r, core_r * scale_in, face * (cone_angle * PI() / 180.0).cos())];
for i in 0..teeth { parts.push(t.rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
let hub = cylinder([0, 0, -8.0], "Z", core_r * 0.8, 8.01);
fuse_all(parts + [hub]) - cylinder([0, 0, -10], "Z", bore / 2.0, 30)
