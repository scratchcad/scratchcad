// Seed drill coulter depth stop collar for a 32 mm coulter stem: 52 mm split collar 20 mm tall with a 3 mm slit, a 16 mm wide pinch boss running 14 mm out past the collar, split by the slit, with an 8.5 mm hole for an M8 pinch bolt, and a 12 mm wide stop lug standing 18 mm out on the opposite side
let stem_d = 32.0; // [20.0, 45.0] Stem diameter (mm)
let collar_d = 52.0; // [36.0, 70.0] Collar diameter (mm)
let height = 20.0; // [14.0, 30.0] Collar height (mm)
let lug_len = 18.0; // [10.0, 30.0] Stop lug length (mm)
const slit = 3.0;
const boss_w = 16.0;
const boss_len = 22.0;
let ri = stem_d / 2.0;
let ro = max(collar_d / 2.0, ri + 5.0);
let boss = box_from_corners([ri + 1.0, -boss_w / 2.0, 0], [ro + boss_len - 8.0, boss_w / 2.0, height]);
let lug = box_from_corners([-ro - lug_len, -6.0, 0], [-ro + 2.0, 6.0, height]);
let lug = lug.fillet(4.0, lug.edges("|Z and <X"));
let collar = fuse_all([cylinder(ro, height), boss, lug]);
let bx = ro + (boss_len - 8.0) / 2.0;
collar - fuse_all([
    cylinder([0, 0, -1.0], "Z", ri, height + 2.0),
    box_from_corners([0, -slit / 2.0, -1.0], [ro + boss_len, slit / 2.0, height + 1.0]),
    cylinder([bx, -boss_w, height / 2.0], "Y", 4.25, 2.0 * boss_w),
])
