// Rotisserie meat fork: 8 mm square spit hole, 30 mm hub 15 mm long, M6 thumb screw boss, 4 prongs 90 mm 4 mm
let spit = 8.0; // [6.0, 12.0] Square spit size (mm)
let hub_d = 30.0; // [20.0, 40.0] Hub diameter (mm)
let prong_l = 90.0; // [60.0, 130.0] Prong length (mm)
let hub = cylinder(hub_d / 2.0, 15.0);
let boss = cylinder([0, 0, 7.5], "X", 6.0, hub_d / 2.0 + 8.0);
let prongs = [];
for k in 0..4 { let a = (k.to_float() * 90.0 + 45.0) * PI() / 180.0; let x = (hub_d / 2.0 - 4.0) * a.cos(); let y = (hub_d / 2.0 - 4.0) * a.sin(); prongs.push(cylinder([x, y, 14.99], "Z", 2.0, prong_l) + cone(2.0, 0.3, 8.0).translate([x, y, 14.99 + prong_l])); }
hub + boss + fuse_all(prongs) - box_centered(spit + 0.4, spit + 0.4, 40.0) - cylinder([0, 0, 7.5], "X", 2.5, hub_d)
