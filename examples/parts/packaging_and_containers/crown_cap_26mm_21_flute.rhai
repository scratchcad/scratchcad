// Crimped crown cork for a 26 mm bottle mouth: 32.1 mm across the 21 flutes, 6 mm tall, 0.3 mm steel with a 0.5 mm PVC liner disc
let flute_diameter = 32.1; // [28.0, 36.0] Diameter over the flutes (mm)
let height = 6.0; // [4.5, 8.0] Overall height (mm)
let flutes = 21; // [15, 27] Number of flutes
let sheet = 0.3; // [0.2, 0.5] Steel thickness (mm)
let flute_depth = 0.7; // [0.3, 1.2] Flute depth (mm)
let rmax = flute_diameter / 2.0;
let rmid = rmax - flute_depth;
fn wavy(rmid, amp, n, z) {
    let pts = [];
    let m = n * 8;
    for i in 0..m {
        let t = i.to_float() * 2.0 * PI() / m.to_float();
        let r = rmid + amp * (n.to_float() * t).cos();
        pts.push([r * t.cos(), r * t.sin(), z]);
    }
    // a fine polygon rather than a spline: a spline skirt fails to measure (#44, Bézier split)
    polygon(pts)
}
let amp = flute_depth / 2.0;
let rm = rmid + amp;
let skirt = face(wavy(rm, amp, flutes, 0), [wavy(rm - sheet, amp, flutes, 0)]).extrude([0, 0, height - 1.2]);
// domed top: the skirt rolls into a flat panel
let top_profile = sketch("XZ")
    .move_to(0, height - sheet)
    .hline_to(rm - 2.5)
    .arc_to(rm - 0.9, height - 0.8, rm - amp - sheet * 0.5, height - 1.6)
    .line_to(rm - amp + sheet * 0.5, height - 1.6)
    .arc_to(rm - 0.9 + sheet * 0.7, height - 0.8 + sheet * 0.7, rm - 2.5, height)
    .hline_to(0)
    .close();
let top = top_profile.to_face().revolve("Z", 360);
let liner = cylinder([0, 0, height - sheet - 0.5], "Z", rm - 2.0, 0.55);
fuse_all([skirt, top, liner])
