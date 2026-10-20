// Fluted round cookie cutter: 60 mm across with 12 scallops 1.5 mm deep, 0.8 mm cutting wall 20 mm tall, 3 mm wide pressing rim 1.5 mm thick on top
let diameter = 60.0; // [30.0, 120.0] Cutter diameter (mm)
let flute_count = 12; // [6, 24] Number of flutes
let flute_depth = 1.5; // [0.0, 4.0] Flute depth (mm)
let height = 20.0; // [10.0, 35.0] Cutter height (mm)
let wall = 0.8; // [0.5, 1.5] Cutting wall thickness (mm)
let rim_width = 3.0; // [1.5, 6.0] Pressing rim width (mm)
let r = diameter / 2.0;
// the scalloped outline offset radially (the flutes are shallow, so the wall stays even)
fn fluted(r, depth, count, extra) {
    let pts = [];
    for i in 0..(count * 8) {
        let a = i.to_float() * 2.0 * PI() / (count * 8).to_float();
        let rr = r - depth / 2.0 + depth / 2.0 * (count.to_float() * a).cos() + extra;
        pts.push([rr * a.cos(), rr * a.sin()]);
    }
    wire([spline(pts, true)])
}
let edge = fluted(r, flute_depth, flute_count, 0.0);
let cutter = face(fluted(r, flute_depth, flute_count, wall), [edge]).extrude([0, 0, height]);
let rim = face(fluted(r, flute_depth, flute_count, wall + rim_width), [edge]).extrude([0, 0, 1.5]).translate([0, 0, height - 1.5]);
cutter + rim
