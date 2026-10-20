// Windscreen suction cup hook for a sun shade or parking disc: 45 mm conical cup 1.2 mm lip, 8 mm stem 14 mm tall, 10 mm wide J hook with a 7 mm throat, pull tab on the rim
let cup_d = 45.0; // [30.0, 60.0] Cup diameter (mm)
let cup_h = 7.0; // [5.0, 10.0] Cup rise (mm)
let stem_h = 14.0; // [8.0, 24.0] Stem height (mm)
let throat = 7.0; // [4.0, 12.0] Hook throat (mm)
let hook_w = 10.0; // [6.0, 14.0] Hook width (mm)

const lip = 1.2;
const stem_r = 4.0;
let r = cup_d / 2.0;
let profile = polygon([
    [0, 0, cup_h - 2.0], [r - 4.0, 0, 0.6], [r, 0, 0], [r, 0, lip], [r - 4.0, 0, lip + 0.9], [stem_r + 1.0, 0, cup_h + 1.0],
    [stem_r, 0, cup_h + 2.0], [stem_r, 0, cup_h + stem_h], [0, 0, cup_h + stem_h]
]);
let cup = profile.to_face().revolve("Z", 360.0);
let zt = cup_h + stem_h;
const t = 3.0;
let hook = fuse_all([
    box_from_corners([-hook_w / 2.0, -stem_r, zt - 2.0], [hook_w / 2.0, stem_r, zt + t]),
    box_from_corners([-hook_w / 2.0, stem_r - 0.5, zt - 2.0], [hook_w / 2.0, stem_r + throat + t, zt + t]),
    box_from_corners([-hook_w / 2.0, stem_r + throat, zt - 2.0 - throat], [hook_w / 2.0, stem_r + throat + t, zt + t])
]);
hook = hook.fillet(1.0, hook.edges("|X"));
let tab = box_from_corners([-4.0, -r - 6.0, 0], [4.0, -r + 1.0, lip]);
tab = tab.fillet(3.9, tab.edges("|Z and <Y"));
fuse_all([cup, hook, tab])
