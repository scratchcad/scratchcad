// Safety cable thimble: teardrop thimble for 6 mm wire rope, 22 x 34 mm inside eye, 10 mm wide with a 6.5 mm groove 2.5 mm deep around the outside
let rope = 6.0; // [3.0, 10.0] Wire rope diameter (mm)
let eye = 22.0; // [14.0, 35.0] Eye width (mm)
let length = 34.0; // [24.0, 50.0] Thimble length (mm)
let wall = 1.2; // [0.8, 2.0] Inner wall (mm)
// convex hull of a big circle (the eye) and a small one (the tip), drawn with straight tangents
fn teardrop(big, small, dist, h) {
    let s = (big - small) / dist;
    let c = (1.0 - s * s).sqrt();
    let tip = PI() - atan(c, s);
    let pts = [];
    for i in 0..=24 {
        let a = -tip + i.to_float() * 2.0 * tip / 24.0;
        pts.push([big * a.sin(), big * a.cos()]);
    }
    for i in 0..=8 {
        let a = tip + i.to_float() * (2.0 * PI() - 2.0 * tip) / 8.0;
        pts.push([small * a.sin(), -dist + small * a.cos()]);
    }
    polygon("XY", pts).to_face().extrude([0, 0, h])
}
let w = rope + 2.0 * wall + 2.0;
let ri = eye / 2.0;
// the inside eye length is ri + (d - 2) + 1; keep the tip well beyond the eye so the teardrop stays convex
let d = (length - ri + 1.0).max(ri + 4.0);
let outer = teardrop(ri + wall + rope * 0.5 + 1.0, 3.0 + rope * 0.5 + wall + 1.0, d, w);
let inner = teardrop(ri, 1.0, d - 2.0, w + 2.0).translate([0, 0, -1.0]);
let groove = teardrop(ri + wall + rope * 0.5 + 2.0, 3.0 + rope * 0.5 + wall + 2.0, d, rope + 0.5).translate([0, 0, (w - rope - 0.5) / 2.0]) - teardrop(ri + wall + rope * 0.5 + 1.0 - 2.5, 3.0 + rope * 0.5 + wall + 1.0 - 2.5, d, w + 2.0).translate([0, 0, -1.0]);
outer - inner - groove
