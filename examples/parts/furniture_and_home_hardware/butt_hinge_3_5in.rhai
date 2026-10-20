// 3.5 x 3.5 in butt hinge: 89 mm long, 2.3 mm leaves, five 10 mm knuckles, 4.6 mm fixed pin, three countersunk screw holes per leaf
let len = 89.0; // [50.0, 127.0] Hinge length (mm)
let leaf_w = 44.5; // [25.0, 64.0] Leaf width from the pin (mm)
let seg = len / 5.0;
let a_zones = [];
let b_zones = [];
let a_kn = [];
let b_kn = [];
for k in 0..5 {
    let x0 = k.to_float() * seg + 0.15;
    let x1 = (k + 1).to_float() * seg - 0.15;
    if k % 2 == 0 { a_kn.push(cylinder([x0, 0, 0], "X", 5.0, x1 - x0)); b_zones.push(cylinder([x0 - 0.3, 0, 0], "X", 5.4, x1 - x0 + 0.6)); }
    else { b_kn.push(cylinder([x0, 0, 0], "X", 5.0, x1 - x0)); a_zones.push(cylinder([x0 - 0.3, 0, 0], "X", 5.4, x1 - x0 + 0.6)); }
}
let a = box_from_corners([0, 3.0, -1.15], [len, leaf_w, 1.15]) - fuse_all(a_zones);
a = fuse_all([a] + a_kn) + cylinder([0, 0, 0], "X", 2.3, len);
let b = box_from_corners([0, -leaf_w, -1.15], [len, -3.0, 1.15]) - fuse_all(b_zones);
b = fuse_all([b] + b_kn) - cylinder([-1, 0, 0], "X", 2.5, len + 2.0);
for x in [len * 0.18, len * 0.5, len * 0.82] {
    a -= cylinder([x, leaf_w * 0.6, -2], "Z", 2.4, 4.0) + cone(2.4, 4.4, 2.0).translate([x, leaf_w * 0.6, -0.85]);
    b -= cylinder([x, -leaf_w * 0.6, -2], "Z", 2.4, 4.0) + cone(2.4, 4.4, 2.0).translate([x, -leaf_w * 0.6, -0.85]);
}
compound([a, b])
