// 50 x 38 mm steel butt hinge, open flat: two 1.5 mm leaves, 5-knuckle 6 mm barrel, 3 countersunk holes per leaf
let length = 50.0; // [25.0, 120.0] Hinge length (mm)
let open_width = 38.0; // [20.0, 80.0] Open width (mm)
let thickness = 1.5; // [0.8, 3.0] Leaf thickness (mm)
let barrel_d = 6.0; // [3.0, 12.0] Barrel diameter (mm)
let knuckles = 5; // [3, 7] Knuckles
let leaf_w = open_width / 2.0;
let leaf = box_from_corners([0, 0, -thickness / 2.0], [leaf_w, length, thickness / 2.0]);
let a = leaf; let b = leaf.mirror("YZ");
let seg = length / knuckles.to_float();
for i in 0..knuckles {
    let k = cylinder([0, i.to_float() * seg + 0.2, 0], "Y", barrel_d / 2.0, seg - 0.4);
    if i % 2 == 0 { a = a + k; } else { b = b + k; }
}
for leaf_x in [leaf_w * 0.6] { for y in [length * 0.2, length * 0.5, length * 0.8] {
    let hole = cylinder([leaf_x, y, -2], "Z", 1.75, 4) + cone(1.75, 3.5, 1.76).translate([leaf_x, y, thickness / 2.0 - 1.75]);
    a = a - hole; b = b - hole.mirror("YZ");
} }
let pin = cylinder([0, -0.5, 0], "Y", barrel_d * 0.25, length + 1.0);
[a - pin, b - pin, pin]
