// Dzus quarter-turn fastener stud: 11 mm wing head 3 mm, 5 mm shank 12 mm with a 1.6 mm spiral cam slot
let head = 11.0; // [8.0, 16.0] Head diameter (mm)
let shank_d = 5.0; // [4.0, 8.0] Shank diameter (mm)
let shank_l = 12.0; // [8.0, 20.0] Shank length (mm)
let h = cylinder(head / 2.0, 3.0) + sphere([0, 0, 0.5], head / 2.0) & cylinder([0, 0, 0], "Z", head / 2.0, 3.5);
let wings = box_centered(head - 1.0, 1.5, 3.0).translate([0, 0, 3.5]);
let s = cylinder([0, 0, -shank_l], "Z", shank_d / 2.0, shank_l + 0.01);
let slots = [];
for k in 0..6 { slots.push(box_centered(shank_d + 2.0, 1.6, 1.6).rotate_z(k.to_float() * 15.0).translate([0, 0, -shank_l + 2.0 + k.to_float() * 0.8])); }
h + wings + s - fuse_all(slots) - cylinder([0, 0, -shank_l - 1.0], "Z", 1.2, 6.0)
