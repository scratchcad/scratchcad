// Large spool cap for a horizontal spool pin: 38 mm flange 2 mm thick, hollow conical skirt with 1.5 mm walls, open underneath, rising to a 12 mm hub; 12 mm long overall, 6.4 mm pin bore 3 mm long through the hub end
let flange_d = 38.0; // [30.0, 46.0] Flange diameter (mm)
let hub_d = 12.0; // [11.0, 16.0] Hub diameter (mm)
let length = 12.0; // [9.0, 18.0] Cap length (mm)
let bore = 6.4; // [5.0, 7.0] Pin bore (mm)
const wall = 1.5;
const flange_t = 2.0;
let rf = flange_d / 2.0;
let rh = hub_d / 2.0;
let rb = bore / 2.0;
let profile = polygon([
    [rf - 3.0 - wall, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [rf - 3.0, 0, flange_t],
    [rh, 0, length], [rb, 0, length], [rb, 0, length - 3.0], [rh - wall, 0, length - 3.0]
]);
profile.to_face().revolve("Z", 360.0)
