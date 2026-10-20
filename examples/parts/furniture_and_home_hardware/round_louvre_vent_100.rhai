// Round louvred vent for 100 mm duct: 140 mm face plate 3 mm thick, angled 1.5 mm slats, 98 mm spigot 40 mm long
let duct = 100.0; // [75.0, 160.0] Duct diameter (mm)
let r = duct / 2.0;
let face = cylinder(r + 20.0, 3.0) - cylinder([0, 0, -1], "Z", r - 1.0, 5.0);
let spigot = cylinder([0, 0, -40.0], "Z", r - 1.0, 41.0) - cylinder([0, 0, -41.0], "Z", r - 2.5, 43.0);
let slats = [];
let n = (duct / 12.0).to_int();
for k in 0..n { slats.push(box_centered(duct + 10.0, 12.0, 1.5).rotate_x(30.0).translate([0, -r + 6.0 + k.to_float() * 12.0, 1.5])); }
let grille = fuse_all(slats) & cylinder([0, 0, -10.0], "Z", r - 0.5, 20.0);
fuse_all([face, spigot, grille])
