// Five-point star charm, 20 mm across the points: faceted top rising 2.5 mm from a 0.8 mm flat edge, 4 mm inner radius, 3.2 mm jump-ring loop on the top point
let star_diameter = 20.0; // [10.0, 40.0] Star diameter over the points (mm)
let inner_ratio = 0.4; // [0.3, 0.6] Inner to outer radius ratio
let facet_height = 2.5; // [1.0, 5.0] Facet height (mm)
let edge = 0.8; // [0.4, 1.5] Flat edge thickness (mm)
let loop_diameter = 3.2; // [2.0, 5.0] Loop diameter (mm)
let ro = star_diameter / 2.0;
let ri = ro * inner_ratio;
fn star(ro, ri, z) {
    let pts = [];
    for i in 0..10 {
        let a = (90.0 + i.to_float() * 36.0) * PI() / 180.0;
        let r = if i % 2 == 0 { ro } else { ri };
        pts.push([r * a.cos(), r * a.sin(), z]);
    }
    polygon(pts)
}
let base = star(ro, ri, 0).to_face().extrude([0, 0, edge]);
let facets = loft([star(ro, ri, edge), star(ro * 0.04, ri * 0.04, edge + facet_height)], true);
let rl = loop_diameter / 2.0;
let lp = cylinder([0, ro + rl - 0.6, 0], "Z", rl, edge) - cylinder([0, ro + rl - 0.6, -1], "Z", rl * 0.5, edge + 2.0);
fuse_all([base, facets, lp])
