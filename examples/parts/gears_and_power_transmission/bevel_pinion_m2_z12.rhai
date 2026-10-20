// Straight bevel pinion module 2, 12 teeth, mating a 24-tooth gear at 90 deg (pitch cone 26.57 deg), 8 mm face
let gear_module = 2.0; // [1.0, 4.0] Module (mm)
let teeth = 12; // [8, 30] Number of teeth
let mate = 24; // [12, 60] Mating gear teeth
let face = 8.0; // [4.0, 16.0] Face width (mm)
let bore = 6.0; // [3.0, 12.0] Bore (mm)
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
let cone_angle = (teeth.to_float() / mate.to_float()).atan() * 180.0 / PI();
let rp = gear_module * teeth.to_float() / 2.0;
let cone_len = rp / (cone_angle * PI() / 180.0).sin();
let k = (cone_len - face) / cone_len;
let h = face * (cone_angle * PI() / 180.0).cos();
let outer = polygon(tooth(gear_module, teeth, 20.0, 0.0));
let t = loft([outer, outer.scale(k).translate([0, 0, h])], true);
let core_r = rp - 1.25 * gear_module;
let parts = [cone(core_r, core_r * k, h), cylinder([0, 0, -10.0], "Z", core_r * 0.9, 10.01)];
for i in 0..teeth { parts.push(t.rotate_z(i.to_float() * 360.0 / teeth.to_float())); }
fuse_all(parts) - cylinder([0, 0, -12], "Z", bore / 2.0, 40)
