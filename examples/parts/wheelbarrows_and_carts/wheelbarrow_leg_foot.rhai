// Wheelbarrow leg stand foot: 70 x 40 mm rubber-style foot 15 mm tall with a 30 x 20 mm socket 10 mm deep for the leg end and 5 grip ribs underneath
let length = 70.0; // [50.0, 100.0] Foot length (mm)
let socket_w = 30.0; // [20.0, 40.0] Leg socket width (mm)
const h = 15.0;
let f = box_centered(length, 40.0, h).translate([0, 0, h / 2.0]);
let f = f.fillet(6.0, f.edges("|Z"));
let sock = box_centered(socket_w, 20.0, 10.0).translate([0, 0, h - 5.0 + 0.01]);
let ribs = [];
for i in 0..5 { ribs.push(box_centered(3.0, 42.0, 2.0).translate([-length / 2.0 + 10.0 + i.to_float() * (length - 20.0) / 4.0, 0, 0.5])); }
f - sock - fuse_all(ribs)
