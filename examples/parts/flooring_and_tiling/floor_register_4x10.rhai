// Floor air register 4 x 10 inch: 300 x 150 mm face plate 4 mm thick over a 102 x 254 mm duct, 10 mm skirt, 8 louvres 4 mm wide on 12 mm centres and 3 mm corner radii
let duct_w = 102.0; // [90.0, 155.0] Duct width (mm)
let duct_l = 254.0; // [200.0, 355.0] Duct length (mm)
const t = 4.0;
let face_ = box_centered(duct_l + 46.0, duct_w + 48.0, t).translate([0, 0, t / 2.0]);
let face_ = face_.fillet(3.0, face_.edges("|Z"));
let skirt = box_centered(duct_l - 2.0, duct_w - 2.0, 10.0).translate([0, 0, -5.0 + 0.01]) - box_centered(duct_l - 6.0, duct_w - 6.0, 12.0).translate([0, 0, -5.0]);
let n = ((duct_w - 10.0) / 12.0).to_int();
let slots = [];
for i in 0..n { slots.push(box_centered(duct_l - 16.0, 4.0, t + 2.0).translate([0, -(n.to_float() - 1.0) * 6.0 + 12.0 * i.to_float(), t / 2.0])); }
face_ + skirt - fuse_all(slots)
