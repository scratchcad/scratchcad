// Bakelite frying pan handle: 180 mm long, tapering from 24 x 18 mm at the pan to 32 x 22 mm at the end, 25 mm mounting boss with an M6 bolt bore, 8 mm hanging hole
let length = 180.0; // [120.0, 250.0] Handle length (mm)
let width_near = 24.0; // [16.0, 35.0] Width at the pan (mm)
let width_far = 32.0; // [20.0, 45.0] Width at the end (mm)
let thickness_near = 18.0; // [12.0, 28.0] Thickness at the pan (mm)
let thickness_far = 22.0; // [14.0, 32.0] Thickness at the end (mm)
let hang_hole = 8.0; // [5.0, 12.0] Hanging hole diameter (mm)
// elliptical section in the YZ plane at distance x
fn ellipse_at(x, w, t) {
    let pts = [];
    for i in 0..24 {
        let a = i.to_float() * 2.0 * PI() / 24.0;
        pts.push([x, w / 2.0 * a.cos(), t / 2.0 * a.sin()]);
    }
    wire([spline(pts, true)])
}
// evenly spaced sections: a smooth loft through unevenly spaced ones overshoots badly
let sections = [];
for k in 0..4 {
    let f = k.to_float() / 3.0;
    sections.push(ellipse_at(length * f, width_near + (width_far - width_near) * f, thickness_near + (thickness_far - thickness_near) * f));
}
let handle = loft(sections, true);
handle = handle.fillet(min(thickness_far / 2.0 - 1.0, 6.0), handle.edges().filter(|e| e.center().x > length - 0.1));
let boss = cylinder([-12.0, 0, 0], "X", 12.5, 14.0).fillet(2.0, "%CIRCLE and <X");
handle = handle + boss;
handle -= cylinder([-13.0, 0, 0], "X", 3.1, 60.0);
handle -= cylinder([10.0, 0, 0], "X", 5.5, 50.0);
handle - cylinder([length - 18.0, 0, -thickness_far], "Z", hang_hole / 2.0, 2.0 * thickness_far)
