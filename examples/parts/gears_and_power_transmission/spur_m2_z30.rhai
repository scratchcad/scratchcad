// Spur gear module 2, 30 teeth, 20 deg, 15 mm face, 12 mm bore with a 4 mm DIN 6885 keyway, 30 mm hub
let gear_module = 2.0; // [0.5, 4.0] Module (mm)
let teeth = 30; // [10, 80] Number of teeth
let face = 15.0; // [5.0, 40.0] Face width (mm)
let bore = 12.0; // [5.0, 30.0] Bore (mm)
let hub_d = 30.0; // [15.0, 60.0] Hub diameter (mm)
let hub_l = 10.0; // [0.0, 30.0] Hub length (mm)
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
let g = gear_blank(gear_module, teeth, 20.0, face);
if hub_l > 0.0 { g = g + cylinder([0, 0, face - 0.01], "Z", hub_d / 2.0, hub_l + 0.01); }
let key = box_from_corners([-2.0, 0, -1], [2.0, bore / 2.0 + 1.8, face + hub_l + 1.0]);
g - cylinder([0, 0, -1], "Z", bore / 2.0, face + hub_l + 2.0) - key
