// Small spool cap for narrow spools: 22 mm flange 1.8 mm thick, short cone to a 10.5 mm hub 9 mm long, 6.4 mm bore, 1.2 mm chamfer on the hub end
let flange_d = 22.0; // [18.0, 28.0] Flange diameter (mm)
let hub_d = 10.5; // [9.0, 13.0] Hub diameter (mm)
let length = 9.0; // [7.0, 12.0] Cap length (mm)
let bore = 6.4; // [5.0, 7.5] Pin bore (mm)
const flange_t = 1.8;
let rf = flange_d / 2.0;
let rh = hub_d / 2.0;
let rb = bore / 2.0;
let ch = min(1.2, rh - rb - 0.5);
let profile = polygon([
    [rb, 0, 0], [rf, 0, 0], [rf, 0, flange_t], [rh + 2.0, 0, flange_t + 2.0],
    [rh, 0, flange_t + 2.0], [rh, 0, length - ch], [rh - ch, 0, length], [rb, 0, length]
]);
profile.to_face().revolve("Z", 360.0)
