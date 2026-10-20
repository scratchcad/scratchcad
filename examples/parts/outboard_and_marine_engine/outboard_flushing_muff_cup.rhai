// Outboard flushing muff cup (one side of a pair): 60 mm round rubber cup 25 mm deep with 3 mm walls and a 2 mm sealing lip, a 20 mm hose spigot 25 mm long with a 14 mm bore and two barb ridges out the back, and two 8 mm ears with 4 mm holes for the spring clamp wire
let cup_d = 60.0; // [40.0, 90.0] Cup diameter (mm)
let cup_depth = 25.0; // [15.0, 40.0] Cup depth (mm)
let spigot_len = 25.0; // [15.0, 40.0] Hose spigot length (mm)
const wall = 3.0;
const spigot_d = 20.0;
let r = cup_d / 2.0;
let profile = polygon([
    [7.0, 0, 0], [r - 2.0, 0, 0], [r, 0, 2.0], [r, 0, cup_depth], [r - 1.0, 0, cup_depth + 2.0], [r - wall + 0.5, 0, cup_depth + 2.0],
    [r - wall, 0, cup_depth], [r - wall, 0, wall], [7.0, 0, wall]]);
let cup = face(profile).revolve("Z", 360.0);
let sr = spigot_d / 2.0;
let sp = polygon([[7.0, 0, 0.5], [sr, 0, 0.5], [sr, 0, -spigot_len * 0.3], [sr + 1.0, 0, -spigot_len * 0.3 - 0.5], [sr, 0, -spigot_len * 0.6],
    [sr + 1.0, 0, -spigot_len * 0.6 - 0.5], [sr - 0.5, 0, -spigot_len], [7.0, 0, -spigot_len]]);
let spigot = face(sp).revolve("Z", 360.0);
let ears = [];
for s in [-1.0, 1.0] {
    let ear = box_centered(10.0, 8.0, 8.0).translate([s * (r + 3.0), 0, cup_depth / 2.0]);
    ears.push(ear - cylinder([s * (r + 4.0), -5.0, cup_depth / 2.0], "Y", 2.0, 10.0));
}
fuse_all([cup, spigot] + ears)
