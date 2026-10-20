// Grow light rope ratchet hanger hook: 5 mm thick flat J hook with a 16 mm eye and 6 mm hole for 1/8 inch rope, a 6 mm wide shank 30 mm long, a 14 mm throat and a 12 mm tip leg ending in a round nose
let throat = 14.0; // [10.0, 24.0] Hook throat (mm)
let shank_len = 30.0; // [20.0, 50.0] Shank length (mm)
let thickness = 5.0; // [4.0, 8.0] Hook thickness (mm)
let rope_hole = 6.0; // [4.0, 8.0] Rope hole diameter (mm)
const bar = 6.0;
let t = thickness;
let er = max(8.0, rope_hole / 2.0 + 4.0);
let eye = cylinder([0, 0, er], "Y", er, t) - cylinder([0, -1.0, er], "Y", rope_hole / 2.0, t + 2.0);
let shank = box_from_corners([-bar / 2.0, 0, -shank_len], [bar / 2.0, t, 0.5]);
let c = throat / 2.0 + bar / 2.0;
let ri = throat / 2.0;
let ro = ri + bar;
let bowl = (cylinder([c, 0, -shank_len], "Y", ro, t) - cylinder([c, -1.0, -shank_len], "Y", ri, t + 2.0)) & box_from_corners([c - ro - 1.0, -1.0, -shank_len - ro - 1.0], [c + ro + 1.0, t + 1.0, -shank_len]);
let tip = box_from_corners([throat + bar / 2.0, 0, -shank_len], [throat + 1.5 * bar, t, -shank_len + 12.0]);
let nose = cylinder([throat + bar, 0, -shank_len + 12.0], "Y", bar / 2.0, t);
fuse_all([eye, shank, bowl, tip, nose]).translate([0, -t / 2.0, 0])
