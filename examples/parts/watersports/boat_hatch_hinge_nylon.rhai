// Small boat hatch hinge: 70 x 38 mm nylon-style butt hinge, 4 mm plates, 7 mm knuckle, 4 x 4.5 mm countersunk holes (two solids)
let length = 70.0; // [40.0, 100.0] Hinge length (mm)
let leaf = 19.0; // [12.0, 30.0] Leaf width (mm)
let t = 4.0; // [3.0, 6.0] Leaf thickness (mm)
const kr = 3.5;
const gap = 0.4;
let seg = length / 5.0;
let a = box_from_corners([kr + gap, 0, 0], [leaf + kr, length, t]);
let b = box_from_corners([-leaf - kr, 0, 0], [-kr - gap, length, t]);
let ka = [];
let kb = [];
for i in 0..5 {
    let k = cylinder([0, i.to_float() * seg + gap / 2.0, kr], "Y", kr, seg - gap) + box_from_corners([0, i.to_float() * seg + gap / 2.0, 0], [kr + gap + 0.01, (i + 1).to_float() * seg - gap / 2.0, t]);
    if i % 2 == 0 { ka.push(k); } else { kb.push(k.mirror([1, 0, 0])); }
}
let pin = cylinder([0, 0, kr], "Y", 1.5, length);
let wa = a + fuse_all(ka) + pin;
let wb = b + fuse_all(kb) - cylinder([0, -1, kr], "Y", 1.8, length + 2.0);
let holes = [];
for x in [leaf * 0.6 + kr, -leaf * 0.6 - kr] { for y in [length * 0.2, length * 0.8] { holes.push(cylinder([x, y, -1], "Z", 2.25, t + 2.0) + cone(2.25, 4.5, 2.25).translate([x, y, t - 2.24])); } }
compound([wa - compound(holes), wb - compound(holes)])
