// Lever (friction plug) lid for a US quart paint can: 0.4 mm tinplate shown 0.5 mm, 87 mm plug 9 mm deep that presses into the can ring, 95 mm outer lip with a 2 mm skirt
let plug_diameter = 87.0; // [60.0, 160.0] Plug diameter (mm)
let plug_depth = 9.0; // [5.0, 14.0] Plug depth (mm)
let lip_width = 4.0; // [2.5, 6.0] Lip width (mm)
let sheet = 0.5; // [0.3, 0.8] Sheet thickness (mm)
let rp = plug_diameter / 2.0;
fn strip(pts, t) {
    let left = [];
    let right = [];
    let n = pts.len();
    for i in 0..n {
        let a = if i == 0 { pts[0] } else { pts[i - 1] };
        let b = if i == n - 1 { pts[n - 1] } else { pts[i + 1] };
        let dr = b[0] - a[0];
        let dz = b[1] - a[1];
        let l = (dr * dr + dz * dz).sqrt();
        let nr = -dz / l * t / 2.0;
        let nz = dr / l * t / 2.0;
        left.push([max(pts[i][0] + nr, 0.0), 0, pts[i][1] + nz]);
        right.insert(0, [max(pts[i][0] - nr, 0.0), 0, pts[i][1] - nz]);
    }
    polygon(left + right)
}
let d = plug_depth;
// centre panel with an expansion bead, plug wall up to the lip, lip folded over the ring with a short skirt
let pts = [[0.0, -d + 1.0], [rp * 0.55, -d + 1.0], [rp * 0.6, -d + 1.8], [rp * 0.65, -d + 1.0], [rp - 2.0, -d + 1.0], [rp - 0.6, -d + 0.3], [rp - 0.2, -d + 1.5], [rp, -1.0], [rp + 0.4, 0.4], [rp + lip_width * 0.5, 1.2], [rp + lip_width - 0.6, 0.5], [rp + lip_width, -0.4], [rp + lip_width + 0.1, -2.0]];
strip(pts, sheet).to_face().revolve("Z", 360)
