// Beard comb: 120 mm, 22 teeth 2 mm wide on a 4.5 mm pitch in two groups, 40 mm tall, 4 mm thick spine 12 mm
let length = 120.0; // [80.0, 160.0] Comb length (mm)
let height = 40.0; // [25.0, 55.0] Overall height (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let spine = box_from_corners([0, 0, 0], [length, 12.0, t]);
let s = spine.fillet(5.9, spine.edges("|Z and >Y"));
let teeth = [];
for i in 0..22 { let w = 2.0; teeth.push(polygon([[0, 0], [w, 0], [w * 0.8, -(height - 12.0)], [w * 0.2, -(height - 12.0)]]).to_face().extrude([0, 0, t]).translate([4.0 + i.to_float() * 4.5 + (if i < 11 { 0.0 } else { 2.0 }), 0.01, 0])); }
s + fuse_all(teeth)
