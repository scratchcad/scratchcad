// Clapperboard clapstick hinge: two-leaf hinge for 22 mm sticks, 40 mm leaves 20 mm wide 3 mm thick, 5-knuckle barrel 6 mm with a 2.5 mm pin, two 3.5 mm countersunk screw holes per leaf, modelled flat as three bodies: two leaves and the pin
let leaf_length = 40.0; // [25.0, 60.0] Leaf length (mm)
let leaf_width = 20.0; // [12.0, 30.0] Leaf width (mm)
let thickness = 3.0; // [2.0, 4.0] Leaf thickness (mm)
let barrel = 6.0; // [4.0, 8.0] Barrel diameter (mm)
let knuckles = 5; // [3, 7] Number of knuckles
let pin = 2.5; // [1.5, 3.5] Pin diameter (mm)
// the two leaves are separate bodies joined by the pin; this models the pinned assembly as two solids
let k_len = leaf_width / knuckles.to_float();
const gap = 0.3;
let leaf_a = box_from_corners([-leaf_length, 0, 0], [0, leaf_width, thickness]);
let leaf_b = box_from_corners([0, 0, 0], [leaf_length, leaf_width, thickness]);
let ka = [];
let kb = [];
for i in 0..knuckles {
    let y0 = i.to_float() * k_len;
    let kn = cylinder([0, y0 + gap / 2.0, barrel / 2.0], "Y", barrel / 2.0, k_len - gap);
    if i % 2 == 0 { ka.push(kn); } else { kb.push(kn); }
}
let clear_a = [];
let clear_b = [];
for i in 0..knuckles {
    let y0 = i.to_float() * k_len;
    let c = cylinder([0, y0, barrel / 2.0], "Y", barrel / 2.0 + 0.3, k_len);
    if i % 2 == 0 { clear_b.push(c); } else { clear_a.push(c); }
}
let a = leaf_a.translate([-barrel / 2.0 + 0.5, 0, 0]) + fuse_all(ka);
let b = leaf_b.translate([barrel / 2.0 - 0.5, 0, 0]) + fuse_all(kb);
let a2 = a - compound(clear_a) - cylinder([0, -1.0, barrel / 2.0], "Y", pin / 2.0 + 0.1, leaf_width + 2.0);
let b2 = b - compound(clear_b) - cylinder([0, -1.0, barrel / 2.0], "Y", pin / 2.0 + 0.1, leaf_width + 2.0);
let screws = [];
for x in [leaf_length * 0.35, leaf_length * 0.8] { for s in [-1.0, 1.0] {
    screws.push(cylinder([s * x, leaf_width / 2.0, -1.0], "Z", 1.75, thickness + 2.0) + cone(1.75, 4.0, 2.25).translate([s * x, leaf_width / 2.0, thickness - 1.75]));
} }
let pin_rod = cylinder([0, -0.5, barrel / 2.0], "Y", pin / 2.0, leaf_width + 1.0);
compound([a2 - fuse_all(screws), b2 - fuse_all(screws), pin_rod])
