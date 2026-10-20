// Square louvred outside wall vent for 100 mm duct: 140 x 140 mm face, 20 mm deep frame with 112 mm square opening, 6 louvre blades 2 mm thick at 45 degrees, 99 mm OD spigot 50 mm with 1.8 mm wall
let face = 140.0; // [120.0, 220.0] Face size (mm)
let depth = 20.0; // [15.0, 35.0] Frame depth (mm)
let blades = 6; // [4, 10] Number of louvre blades
let spigot_d = 99.0; // [60.0, 105.0] Spigot outside diameter (mm)
let spigot_l = 50.0; // [30.0, 100.0] Spigot length (mm)
const blade_t = 2.0;
const wall = 1.8;
let op = face - 28.0;
let frame = box_centered(face, face, depth).translate([0, 0, depth / 2.0]);
frame = frame.fillet(6.0, "|Z");
frame = frame - box_centered(op, op, depth + 2.0).translate([0, 0, depth / 2.0]);
let back = box_centered(face, face, 3.0).translate([0, 0, 1.5]) - cylinder([0, 0, -1], "Z", spigot_d / 2.0 - wall, 5.0);
let pitch = op / blades.to_float();
let bw = min(pitch * 1.3, (depth - 4.0) * 1.3);
let louvres = [];
for i in 0..blades {
    let y = -op / 2.0 + pitch * (i.to_float() + 0.5);
    louvres.push(box_centered(op + 2.0, blade_t, bw).rotate_x(45.0).translate([0, y, depth / 2.0 + 1.0]));
}
let spigot = cylinder([0, 0, -spigot_l], "Z", spigot_d / 2.0, spigot_l + 1.0) - cylinder([0, 0, -spigot_l - 1.0], "Z", spigot_d / 2.0 - wall, spigot_l + 3.0);
fuse_all([frame, back, spigot] + louvres)
