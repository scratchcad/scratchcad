// Outboard transom clamp screw T-handle: 22 mm boss 25 mm long with a 12.2 mm bore for the M12 clamp screw and a 4 mm cross-pin hole, and a 14 mm round bar 90 mm long through the top with 1.5 mm chamfered ends
let bar_len = 90.0; // [60.0, 140.0] Handle bar length (mm)
let bar_d = 14.0; // [10.0, 18.0] Handle bar diameter (mm)
let screw_d = 12.2; // [8.2, 16.2] Clamp screw bore (mm)
const boss_len = 25.0;
let boss_r = max(11.0, screw_d / 2.0 + 4.5);
let boss = cylinder([0, 0, 0], "Z", boss_r, boss_len + bar_d / 2.0);
let boss = boss.chamfer(1.0, boss.edges("<Z"));
let bar = cylinder([-bar_len / 2.0, 0, boss_len + bar_d / 2.0], "X", bar_d / 2.0, bar_len);
let bar = bar.chamfer(1.5, bar.edges("%CIRCLE"));
let handle = boss + bar;
let cuts = [cylinder([0, 0, -1.0], "Z", screw_d / 2.0, boss_len), cylinder([0, -boss_r - 1.0, boss_len * 0.45], "Y", 2.0, 2.0 * boss_r + 2.0)];
handle - fuse_all(cuts)
