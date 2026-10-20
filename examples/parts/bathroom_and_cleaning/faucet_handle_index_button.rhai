// Faucet handle index button (hot/cold cap): 13 mm domed cap 3 mm, 5 mm colour dot recess, 3 split snap legs 4 mm long with a 0.4 mm retaining lip for a 12 mm hole
let cap_d = 13.0; // [10.0, 20.0] Cap diameter (mm)
let cap_h = 3.0; // [2.0, 5.0] Cap height (mm)
let hole_d = 11.6; // [8.0, 18.0] Handle hole diameter (mm)
let leg_l = 4.0; // [3.0, 7.0] Snap leg length (mm)
let r = cap_d / 2.0;
const rise = 1.0;
let sr = (r * r + rise * rise) / (2.0 * rise);
let cap = sphere([0, 0, cap_h - sr], sr) & cylinder(r, cap_h);
let dot = cylinder([0, 0, cap_h - 0.6], "Z", 2.5, 2.0);
let lr = hole_d / 2.0;
let legs = cylinder([0, 0, -leg_l], "Z", lr, leg_l + 0.5) - cylinder([0, 0, -leg_l - 1.0], "Z", lr - 0.9, leg_l + 2.0);
let lip = cone(lr + 0.4, lr - 0.3, 1.2).translate([0, 0, -leg_l]) - cylinder([0, 0, -leg_l - 1.0], "Z", lr - 0.9, 3.0);
let slots = [];
for i in 0..3 { slots.push(box_from_corners([0, -0.6, -leg_l - 1.0], [lr + 2.0, 0.6, -0.5]).rotate_z(i.to_float() * 120.0 + 60.0)); }
cap + legs + lip - dot - compound(slots)
