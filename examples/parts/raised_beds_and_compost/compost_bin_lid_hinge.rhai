// Compost bin lid hinge: 60 x 40 mm leaf pair 3 mm with 4 knuckles 8 mm and 3 mm pin, 2 holes each leaf (two solids)
let length = 60.0; // [40.0, 90.0] Hinge length (mm)
let leaf = 40.0; // [25.0, 60.0] Leaf width (mm)
let t = 3.0; // [2.0, 5.0] Leaf thickness (mm)
const kr = 4.0;
let seg = length / 4.0;
let a = box_from_corners([kr + 0.4, 0, 0], [leaf, length, t]);
let b = box_from_corners([-leaf, 0, 0], [-kr - 0.4, length, t]);
let ka = [];
let kb = [];
for i in 0..4 {
    let y0 = i.to_float() * seg + 0.2;
    let k = cylinder([0, y0, kr], "Y", kr, seg - 0.4);
    if i % 2 == 0 { ka.push(k + box_from_corners([0, y0, 0], [kr + 0.5, y0 + seg - 0.4, t])); } else { kb.push(k + box_from_corners([-kr - 0.5, y0, 0], [0, y0 + seg - 0.4, t])); }
}
let pin = cylinder([0, 0, kr], "Y", 1.4, length);
let wa = a + fuse_all(ka) + pin - cylinder([leaf * 0.6, length * 0.25, -1], "Z", 2.25, t + 2.0) - cylinder([leaf * 0.6, length * 0.75, -1], "Z", 2.25, t + 2.0);
let wb = b + fuse_all(kb) - cylinder([0, -1, kr], "Y", 1.7, length + 2.0) - cylinder([-leaf * 0.6, length * 0.25, -1], "Z", 2.25, t + 2.0) - cylinder([-leaf * 0.6, length * 0.75, -1], "Z", 2.25, t + 2.0);
compound([wa, wb])
