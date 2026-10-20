// 40 mm trap compression cone seal ring (for 42.8 mm waste pipe): 43 mm bore, 50 mm base, tapering to 44.5 mm over 9 mm, 1.5 mm square heel
let bore = 43.0; // [30.0, 60.0] Ring bore (mm)
let base_od = 50.0; // [36.0, 70.0] Base outside diameter (mm)
let height = 9.0; // [5.0, 15.0] Ring height (mm)
let tip_wall = 0.75; // [0.5, 2.0] Wall at the tip (mm)
let ri = bore / 2.0;
let rb = max(base_od / 2.0, ri + 2.5);
let rt = ri + tip_wall;
const heel = 1.5;
polygon([[ri, 0, 0], [rb, 0, 0], [rb, 0, heel], [rt, 0, height], [ri, 0, height]]).to_face().revolve("Z", 360)
