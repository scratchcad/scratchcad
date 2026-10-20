// 4 x 10 in floor register: 120 x 272 mm flange 3 mm thick with rounded corners, fourteen 4 mm slots, 100 x 250 mm drop-in boot 50 mm deep
let duct_w = 100.0; // [75.0, 150.0] Duct width (mm)
let duct_l = 250.0; // [200.0, 350.0] Duct length (mm)
let flange = box_centered(duct_w + 20.0, duct_l + 22.0, 3.0).translate([0, 0, 1.5]).fillet(6.0, "|Z").chamfer(1.0, ">Z");
let boot = box_centered(duct_w, duct_l, 50.0).translate([0, 0, -25.0]) - box_centered(duct_w - 4.0, duct_l - 4.0, 52.0).translate([0, 0, -26.0]);
let reg = flange + boot;
let slots = [];
for k in 0..14 { slots.push(box_centered(duct_w - 20.0, 4.0, 10.0).translate([0, -(duct_l - 30.0) / 2.0 + k.to_float() * ((duct_l - 30.0) / 13.0), 0])); }
reg - fuse_all(slots)
