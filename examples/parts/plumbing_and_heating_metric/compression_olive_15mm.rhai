// 15 mm compression olive (EN 1254-2 brass ring): 15.1 mm bore, 17.4 mm barrel OD, 6.5 mm long, both ends tapered to 16.0 mm over 2 mm
let bore = 15.1; // [6.1, 28.1] Pipe size bore (mm)
let barrel_od = 17.4; // [8.0, 31.0] Barrel outside diameter (mm)
let length = 6.5; // [4.0, 10.0] Olive length (mm)
let end_od = 16.0; // [7.0, 29.5] Tapered end diameter (mm)
let ri = bore / 2.0;
let ro = max(barrel_od / 2.0, ri + 0.6);
let re = min(max(end_od / 2.0, ri + 0.25), ro - 0.05);
let taper = length * 0.3;
let profile = polygon([[ri, 0, 0], [re, 0, 0], [ro, 0, taper], [ro, 0, length - taper], [re, 0, length], [ri, 0, length]]);
profile.to_face().revolve("Z", 360)
