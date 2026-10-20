// Faucet handle spline adapter: 14 mm sleeve 15 mm long, 20-tooth broached bore for an 8 mm spindle (root 8.0, tips 9.0 mm), 4.2 mm screw hole through the top, knurled outside
let od = 14.0; // [11.0, 20.0] Sleeve diameter (mm)
let length = 15.0; // [10.0, 25.0] Sleeve length (mm)
let teeth = 20; // [12, 24] Spline teeth
let spline_d = 8.0; // [6.0, 11.0] Spline root diameter (mm)
let depth = 11.0; // [6.0, 18.0] Spline depth (mm)
let r0 = spline_d / 2.0;
let r1 = r0 + 0.5;
let pts = [];
let n = 2 * teeth;
for i in 0..n {
    let a = i.to_float() * 2.0 * PI() / n.to_float();
    let rr = if i % 2 == 0 { r1 } else { r0 };
    pts.push([rr * a.cos(), rr * a.sin(), -1.0]);
}
let spline_cut = polygon(pts).to_face().extrude([0, 0, depth + 1.0]);
let sleeve = cylinder(od / 2.0, length);
let knurl = [];
for i in 0..24 { knurl.push(box_from_corners([od / 2.0 - 0.3, -0.4, 2.0], [od / 2.0 + 0.5, 0.4, length - 2.0]).rotate_z(i.to_float() * 15.0)); }
sleeve + fuse_all(knurl) - spline_cut - cylinder([0, 0, 0], "Z", 2.1, length + 1.0)
