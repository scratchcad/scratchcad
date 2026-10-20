// Car air-vent phone mount clip: 2 x 25 mm prongs 2 mm thick for 1.5 mm louvres, 17 mm ball stud on a 30 mm pad
let prong = 25.0; // [15.0, 35.0] Prong length (mm)
let ball = 17.0; // [14.0, 20.0] Ball diameter (mm)
let pad = box_centered(30.0, 30.0, 4.0).translate([0, 0, 2.0]);
let p = pad.fillet(5.0, pad.edges("|Z"));
let prongs = [];
for x in [-4.0, 4.0] { prongs.push(box_from_corners([x - 1.0, -10.0, -prong], [x + 1.0, 10.0, 0.01])); }
let hooks = box_from_corners([-6.0, -10.0, -prong], [-5.0 + 0.01, 10.0, -prong + 4.0]) + box_from_corners([4.99, -10.0, -prong], [6.0, 10.0, -prong + 4.0]);
let neck = cylinder([0, 0, 3.99], "Z", 4.0, 8.0);
p + fuse_all(prongs) + hooks + neck + sphere([0, 0, 12.0 + ball / 2.0 - 2.0], ball / 2.0)
