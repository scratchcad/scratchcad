// Gas turbine blade: fir-tree root 14 mm wide 24 mm long, 20 x 24 mm platform, cambered blade 48 mm tall twisting 20 deg, 20 to 16 mm chord
let height = 48.0; // [25.0, 100.0] Blade height (mm)
let twist = 20.0; // [0.0, 40.0] Twist (deg)
fn naca(chord, m, p, th, n) {
    let up = [];
    let lo = [];
    for i in 0..=n {
        let x = (1.0 - (PI() * i.to_float() / n.to_float()).cos()) / 2.0;
        let yt = 5.0 * th * (0.2969 * sqrt(x) - 0.1260 * x - 0.3516 * x * x + 0.2843 * x * x * x - 0.1036 * x * x * x * x);
        let yc = if x < p { m / (p * p) * (2.0 * p * x - x * x) } else { m / ((1.0 - p) * (1.0 - p)) * (1.0 - 2.0 * p + 2.0 * p * x - x * x) };
        up.push([chord * x, chord * (yc + yt)]);
        lo.push([chord * x, chord * (yc - yt)]);
    }
    up.reverse();
    let pts = up;
    for i in 1..n { pts.push(lo[i]); }
    pts
}
fn section(chord, z, deg) {
    let a = deg * PI() / 180.0;
    let pts = [];
    for p in naca(chord, 0.06, 0.4, 0.15, 20) {
        let u = p[0] - chord / 2.0;
        let v = p[1];
        pts.push([v * a.cos() - u * a.sin(), v * a.sin() + u * a.cos(), z]);
    }
    polygon(pts)
}
let root = polygon([[-7, 0, 0], [7, 0, 0], [7, 0, 2], [5, 0, 3.5], [6.5, 0, 5], [4.5, 0, 6.5], [6, 0, 8], [4, 0, 10.5], [-4, 0, 10.5], [-6, 0, 8], [-4.5, 0, 6.5], [-6.5, 0, 5], [-5, 0, 3.5], [-7, 0, 2]]).to_face().extrude([0, 24.0, 0]).translate([0, -12.0, 0]);
let platform = box_from_corners([-10.0, -12.0, 10.0], [10.0, 12.0, 12.0]);
let blade = loft([section(20.0, 11.5, 0.0), section(18.0, 12.0 + height / 2.0, twist / 2.0), section(16.0, 12.0 + height, twist)], true);
fuse_all([root, platform, blade])
