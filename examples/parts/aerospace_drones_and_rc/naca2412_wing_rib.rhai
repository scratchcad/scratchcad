// NACA 2412 wing rib: 150 mm chord, 2 mm plywood, 8 mm spar hole at 25% on the camber line, two lightening holes
let chord = 150.0; // [80.0, 300.0] Chord (mm)
let t = 2.0; // [1.5, 4.0] Rib thickness (mm)
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
fn camber(chord, x) { let m = 0.02; let p = 0.4; chord * (if x < p { m / (p * p) * (2.0 * p * x - x * x) } else { m / ((1.0 - p) * (1.0 - p)) * (1.0 - 2.0 * p + 2.0 * p * x - x * x) }) }
let rib = polygon(naca(chord, 0.02, 0.4, 0.12, 40)).to_face().extrude(t);
rib -= cylinder([0.25 * chord, camber(chord, 0.25), -1], "Z", 4.0 * chord / 150.0, t + 2.0);
rib -= cylinder([0.45 * chord, camber(chord, 0.45), -1], "Z", 6.0 * chord / 150.0, t + 2.0);
rib - cylinder([0.62 * chord, camber(chord, 0.62), -1], "Z", 4.0 * chord / 150.0, t + 2.0)
