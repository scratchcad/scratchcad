// Stepped hex radiator valve tail spanner: 6 hex steps 10, 12, 14, 16, 17 and 19 mm across flats, each 9 mm long, 8 mm tommy-bar cross hole in the largest step
let first_af = 10.0; // [8.0, 12.0] Smallest hex across flats (mm)
let step_len = 9.0; // [6.0, 14.0] Step length (mm)
let bar = 8.0; // [5.0, 10.0] Tommy bar hole diameter (mm)
let sizes = [first_af, first_af + 2.0, first_af + 4.0, first_af + 6.0, first_af + 7.0, first_af + 9.0];
let n = sizes.len();
let total = n.to_float() * step_len;
let parts = [];
for k in 0..n {
    let af = sizes[k];
    let rc = af / 3.0.sqrt();
    let pts = [];
    for i in 0..6 {
        let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
        pts.push([rc * a.cos(), rc * a.sin(), 0]);
    }
    let len = total - k.to_float() * step_len;
    parts.push(polygon(pts).to_face().extrude([0, 0, len]));
}
let body = fuse_all(parts);
body - cylinder([-20.0, 0, step_len * 0.5], "X", min(bar, sizes[n - 1] - 4.0) / 2.0, 40.0)
