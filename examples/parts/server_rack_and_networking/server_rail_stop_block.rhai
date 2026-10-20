// Server rail rear stop block: 30 x 20 x 15 mm block that clips into a 9.5 mm square rack hole with a 9 mm square spigot 6 mm long and 1 mm snap barbs, with a 5 mm rubber bumper recess
let spigot = 9.0; // [8.8, 9.4] Spigot square size (mm)
let block_l = 30.0; // [20.0, 45.0] Block length (mm)
let b = box_centered(block_l, 20.0, 15.0).translate([0, 0, 7.5]);
let sp = box_centered(spigot, spigot, 6.0).translate([0, 0, -3.0 + 0.01]);
let barbs = box_centered(spigot + 2.0, 2.0, 1.0).translate([0, 0, -5.5]);
let slit = box_centered(spigot + 4.0, 1.5, 5.0).translate([0, 0, -3.5]);
b + sp + barbs - slit - cylinder([block_l / 2.0 - 6.0, 0, 14.0], "Z", 2.5, 2.0)
