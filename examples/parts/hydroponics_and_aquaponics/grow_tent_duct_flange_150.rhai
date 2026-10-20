// Grow tent / room duct flange for 150 mm ducting: 188 mm square plate 4 mm thick with 10 mm rounded corners and four 5 mm screw holes on 168 mm centres, a 148 mm spigot 50 mm long with a 2 mm wall and a 2 mm hose-clamp bead 8 mm from its end
let duct_d = 150.0; // [100.0, 250.0] Duct inside diameter (mm)
let spigot_len = 50.0; // [30.0, 80.0] Spigot length (mm)
let plate_margin = 20.0; // [12.0, 40.0] Plate margin around the spigot (mm)
const t = 4.0;
const wall = 2.0;
let ro = duct_d / 2.0 - 1.0;
let ri = ro - wall;
let side = 2.0 * ro + 2.0 * plate_margin;
let plate = box_centered(side, side, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(10.0, plate.edges("|Z"));
let sp = face(polygon([[ri, 0, t - 0.5], [ro, 0, t - 0.5], [ro, 0, t + spigot_len - 10.0], [ro + 2.0, 0, t + spigot_len - 9.0], [ro + 2.0, 0, t + spigot_len - 7.0], [ro, 0, t + spigot_len - 6.0], [ro, 0, t + spigot_len], [ri, 0, t + spigot_len]])).revolve("Z", 360.0);
let body = plate + sp;
let hp = side / 2.0 - plate_margin / 2.0;
let cuts = [cylinder([0, 0, -1.0], "Z", ri, t + 2.0)];
for x in [-1.0, 1.0] {
    for y in [-1.0, 1.0] {
        cuts.push(cylinder([x * hp, y * hp, -1.0], "Z", 2.5, t + 2.0));
    }
}
body - fuse_all(cuts)
