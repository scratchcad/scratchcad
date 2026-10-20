// Beech wooden spoon: 300 mm long, 62 x 46 mm elliptical bowl 9 mm deep with a 3 mm rim, rounded handle 14 x 9 mm at the bowl widening to 20 mm, round end
let length = 300.0; // [200.0, 400.0] Overall length (mm)
let bowl_length = 62.0; // [40.0, 90.0] Bowl length (mm)
let bowl_width = 46.0; // [30.0, 70.0] Bowl width (mm)
let bowl_depth = 9.0; // [4.0, 15.0] Bowl depth (mm)
let rim = 3.0; // [2.0, 5.0] Rim width (mm)
let thickness = 12.0; // [8.0, 18.0] Bowl body thickness (mm)
// elliptical outline as a closed spline
fn ellipse(a, b, extra) {
    let pts = [];
    for i in 0..36 {
        let t = i.to_float() * 2.0 * PI() / 36.0;
        pts.push([(a + extra) * t.cos(), (b + extra) * t.sin()]);
    }
    wire([spline(pts, true)])
}
let a = bowl_length / 2.0;
let b = bowl_width / 2.0;
// bowl body: elliptical prism trimmed underneath by a large sphere, the cavity by a smaller one
let r_under = a * a / thickness / 1.2 + thickness / 2.0;
let body = face(ellipse(a, b, 0.0)).extrude([0, 0, thickness + 2.0]).translate([0, 0, -thickness]);
body = body & sphere([0, 0, r_under - thickness], r_under);
let rc = (a - rim) * (a - rim) / (2.0 * bowl_depth) + bowl_depth / 2.0;
let cavity = face(ellipse(a - rim, b - rim, 0.0)).extrude([0, 0, bowl_depth + 2.0]).translate([0, 0, -bowl_depth - 0.5]) & sphere([0, 0, rc - bowl_depth], rc);
body = body.fillet(1.5, body.edges().filter(|e| e.center().z > -0.1)) - cavity;
// handle: a flat bar tapering wider toward the end, rounded over, dipping to meet the bowl rim
let hl = length - bowl_length + 4.0;
let outline = polygon([[a - 2.5, -7.0], [a - 2.5 + hl * 0.5, -8.5], [a - 2.5 + hl - 10.0, -10.0], [a - 2.5 + hl - 10.0, 10.0], [a - 2.5 + hl * 0.5, 8.5], [a - 2.5, 7.0]]);
let handle = face(outline).extrude([0, 0, 9.0]).translate([0, 0, -9.0]) + cylinder([a - 12.5 + hl, 0, -9.0], "Z", 10.0, 9.0);
handle = handle.fillet(3.5, "not |Z");
body + handle
