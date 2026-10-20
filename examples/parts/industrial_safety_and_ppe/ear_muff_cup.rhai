// Ear muff cup: elliptical 70 x 95 mm shell 42 mm deep, 2.5 mm wall, open cushion side with a 4 mm flange lip, two 10 mm headband pivot bosses with 6 mm pivot holes
let cup_width = 70.0; // [55.0, 85.0] Cup width (mm)
let cup_height = 95.0; // [75.0, 110.0] Cup height (mm)
let depth = 42.0; // [30.0, 55.0] Cup depth (mm)
let wall = 2.5; // [1.8, 4.0] Wall thickness (mm)
const n = 48;
fn ellipse_pts(a, b, count) {
    let pts = [];
    for i in 0..count {
        let t = i.to_float() * 2.0 * PI() / count.to_float();
        pts.push([a * t.cos(), b * t.sin()]);
    }
    pts
}
let outer = polygon("XY", ellipse_pts(cup_width / 2.0, cup_height / 2.0, n)).to_face().extrude([0, 0, depth]);
let cavity = polygon("XY", ellipse_pts(cup_width / 2.0 - wall, cup_height / 2.0 - wall, n)).to_face().extrude([0, 0, depth - wall + 1.0]).translate([0, 0, -1.0]);
let lip = polygon("XY", ellipse_pts(cup_width / 2.0 + 4.0, cup_height / 2.0 + 4.0, n)).to_face().extrude([0, 0, 2.5]);
let bosses = [];
let pivots = [];
for s in [-1.0, 1.0] {
    bosses.push(cylinder([s * (cup_width / 2.0 - 2.0), 0, depth * 0.6], [s, 0, 0], 5.0, 6.0));
    pivots.push(cylinder([s * (cup_width / 2.0 + 5.0), 0, depth * 0.6], [-s, 0, 0], 3.0, 6.0));
}
(outer + lip + fuse_all(bosses)) - cavity - compound(pivots)
