// Acetate sunglasses temple tip, 46 mm along its centreline: 25 mm straight sleeve then a 40 degree bend on a 30 mm radius, oval section growing from 3.6 x 2.6 to 5 x 3.4 mm, 1.5 mm bore 20 mm deep for the temple wire
let straight_length = 25.0; // [10.0, 40.0] Straight length (mm)
let bend_angle = 40.0; // [10.0, 60.0] Bend angle (degrees)
let bend_radius = 30.0; // [15.0, 60.0] Bend radius (mm)
let start_width = 3.6; // [2.5, 5.0] Width at the hinge end (mm)
let end_width = 5.0; // [3.0, 7.0] Width at the ear end (mm)
let bore = 1.5; // [0.8, 2.5] Wire bore diameter (mm)
const n = 10;
fn oval_yz(a, b) {
    let pts = [];
    for i in 0..24 {
        let t = i.to_float() * 15.0 * PI() / 180.0;
        pts.push([0, a * t.cos(), b * t.sin()]);
    }
    wire([spline(pts, true)])
}
let bend = bend_angle * PI() / 180.0;
let total = straight_length + bend_radius * bend;
let sections = [];
for i in 0..=n {
    let s = total * i.to_float() / n.to_float();
    let f = i.to_float() / n.to_float();
    let w = start_width + (end_width - start_width) * f;
    let sec = oval_yz(w / 2.0, w * 0.35);
    if s <= straight_length {
        sections.push(sec.translate([s, 0, 0]));
    } else {
        let phi = (s - straight_length) / bend_radius;
        sections.push(sec.rotate_y(phi * 180.0 / PI()).translate([straight_length + bend_radius * phi.sin(), 0, -bend_radius * (1.0 - phi.cos())]));
    }
}
let tip = loft(sections, true);
tip - cylinder([-1.0, 0, 0], "X", min(bore, start_width * 0.5) / 2.0, min(21.0, straight_length + 1.0))
