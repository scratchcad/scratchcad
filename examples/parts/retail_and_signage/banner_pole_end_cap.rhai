// Banner pole end cap for 25 mm tube: 28 mm ball finial, 22.5 mm spigot 20 mm with 3 grip ribs
let tube_id = 22.5; // [15.0, 35.0] Tube inside diameter (mm)
let ball = 28.0; // [20.0, 45.0] Ball diameter (mm)
let spigot_l = 20.0; // [12.0, 35.0] Spigot length (mm)
let collar = cylinder(tube_id / 2.0 + 1.75, 3.0);
let b = sphere([0, 0, 3.0 + ball / 2.0 - 2.0], ball / 2.0);
let spigot = cylinder([0, 0, -spigot_l], "Z", tube_id / 2.0 - 0.3, spigot_l + 0.01);
let ribs = [];
for k in 0..3 { ribs.push(cylinder([0, 0, -spigot_l + 4.0 + k.to_float() * 5.0], "Z", tube_id / 2.0 + 0.3, 1.2)); }
collar + b + spigot + fuse_all(ribs) - cylinder([0, 0, -spigot_l - 1.0], "Z", tube_id / 2.0 - 2.5, spigot_l)
