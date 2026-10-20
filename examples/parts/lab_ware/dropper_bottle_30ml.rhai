// 30 ml amber dropper bottle: 32 mm body 60 mm tall with shoulder to an 18 mm neck, 1.5 mm wall; cap with glass pipette and rubber bulb
let d = 32.0; // [24.0, 50.0] Body diameter (mm)
let r = d / 2.0;
let p = [[0, 0, 0], [r - 2.0, 0, 0], [r, 0, 2.0], [r, 0, 50.0], [9.0, 0, 58.0], [9.0, 0, 68.0], [7.5, 0, 68.0], [7.5, 0, 58.5], [r - 1.5, 0, 50.0], [r - 1.5, 0, 2.5], [0, 0, 1.5]];
let bottle = polygon(p).to_face().revolve("Z", 360);
let cap = cylinder([0, 0, 60.0], "Z", 10.5, 12.0) - cylinder([0, 0, 59.0], "Z", 9.1, 9.0);
let bulb = cylinder([0, 0, 71.9], "Z", 6.0, 10.0) + sphere([0, 0, 82.0], 6.5);
let pipette = cylinder([0, 0, 8.0], "Z", 3.5, 64.0) - cylinder([0, 0, 7.0], "Z", 1.0, 70.0);
compound([bottle, fuse_all([cap, bulb, pipette])])
