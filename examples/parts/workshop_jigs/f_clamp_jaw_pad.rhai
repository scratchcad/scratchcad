// Snap-on soft pad for an F-clamp jaw: fits an 18 x 30 mm jaw face, 34 x 24 x 10 mm cap, 6 mm deep pocket with retaining lips, grooved grip face
let jaw_w = 18.0; // [12.0, 30.0] Jaw width (mm)
let jaw_l = 30.0; // [20.0, 50.0] Jaw length (mm)
let pocket = 6.0; // [3.0, 10.0] Pocket depth (mm)
let face = 4.0; // [2.0, 6.0] Pad face thickness (mm)
let wall = 2.0; // [1.5, 3.0] Side wall (mm)
let ow = jaw_w + 2.0 * wall;
let ol = jaw_l + 2.0 * wall;
let h = pocket + face;
let cap = box_centered(ol, ow, h).translate([0, 0, h / 2.0]);
let c = cap.fillet(1.5, cap.edges("|Z"));
let cut = box_centered(jaw_l, jaw_w, pocket * 2.0).translate([0, 0, h]);
let lips = [];
for s in [-1.0, 1.0] { lips.push(box_from_corners([-jaw_l / 2.0, s * jaw_w / 2.0 - 0.6, h - 1.2], [jaw_l / 2.0, s * jaw_w / 2.0 + 0.6, h - 0.4])); }
let grooves = [];
for i in 0..5 { grooves.push(box_from_corners([-ol / 2.0 - 1.0, -ow / 2.0 + 3.0 + i.to_float() * (ow - 6.0) / 4.0 - 0.5, -1], [ol / 2.0 + 1.0, -ow / 2.0 + 3.0 + i.to_float() * (ow - 6.0) / 4.0 + 0.5, 0.8])); }
c - cut + fuse_all(lips) - compound(grooves)
