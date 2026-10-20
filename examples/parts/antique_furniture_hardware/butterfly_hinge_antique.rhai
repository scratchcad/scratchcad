// Butterfly cabinet hinge: 50 mm tall, two 35 mm wings with scalloped edges 1.5 mm, 5 mm knuckle, 4 countersunk holes (two solids)
let height = 50.0; // [35.0, 75.0] Hinge height (mm)
let wing = 35.0; // [25.0, 50.0] Wing width (mm)
let t = 1.5; // [1.0, 2.5] Leaf thickness (mm)
const kr = 2.5;
let seg = height / 5.0;
fn leaf(height, wing, t) {
    polygon([[0, 0], [wing * 0.5, 0], [wing, -height * 0.15], [wing * 0.85, height * 0.5], [wing, height * 1.15], [wing * 0.5, height], [0, height]]).to_face().extrude([0, 0, t])
}
let a = leaf(height, wing, t).rotate_x(90.0).translate([kr, t, 0]);
let b = leaf(height, wing, t).rotate_x(90.0).mirror([1, 0, 0]).translate([-kr, t, 0]);
let ka = [];
let kb = [];
for i in 0..5 { let k = cylinder([0, 0, i.to_float() * seg + 0.2], "Z", kr, seg - 0.4) + box_from_corners([0, 0, i.to_float() * seg + 0.2], [if i % 2 == 0 { kr + 0.5 } else { -kr - 0.5 }, t, (i + 1).to_float() * seg - 0.2]); if i % 2 == 0 { ka.push(k); } else { kb.push(k); } }
let pin = cylinder([0, 0, 0], "Z", 1.0, height);
let holes_a = cylinder([kr + wing * 0.5, -1, height * 0.3], "Y", 1.6, t + 2.0) + cylinder([kr + wing * 0.5, -1, height * 0.7], "Y", 1.6, t + 2.0);
let holes_b = cylinder([-kr - wing * 0.5, -1, height * 0.3], "Y", 1.6, t + 2.0) + cylinder([-kr - wing * 0.5, -1, height * 0.7], "Y", 1.6, t + 2.0);
compound([a + fuse_all(ka) + pin - holes_a, b + fuse_all(kb) - cylinder([0, 0, -1], "Z", 1.2, height + 2.0) - holes_b])
