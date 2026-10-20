// 100 grain field point for 5/16 inch shafts: 7.9 mm body 18 mm long, 15 degree bullet tip 9 mm, 6.0 mm glue-in shank 14 mm with a glue groove
let body_d = 7.9; // [6.5, 9.5] Point body diameter (mm)
let body_l = 18.0; // [12.0, 25.0] Body length (mm)
let shank_d = 6.0; // [4.5, 7.0] Shank diameter (mm)
const tip_l = 9.0;
let shank = cylinder([0, 0, -14.0], "Z", shank_d / 2.0, 14.01) - (cylinder([0, 0, -8.0], "Z", shank_d / 2.0 + 1.0, 1.0) - cylinder([0, 0, -9.0], "Z", shank_d / 2.0 - 0.4, 3.0));
let body = cylinder([0, 0, 0], "Z", body_d / 2.0, body_l);
let tip = cone(body_d / 2.0, 0.6, tip_l).translate([0, 0, body_l - 0.01]);
shank + body + tip
