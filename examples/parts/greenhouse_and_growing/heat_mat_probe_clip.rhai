// Heat mat thermostat probe clip: holds a 6 mm thermostat probe at root depth in a seed tray cell, 80 mm stake 8 x 3 mm with a pointed tip, 6.2 mm snap channel at the top with a 4.5 mm mouth and a 3 mm cable hook
// # Stake
let length = 80.0; // [50.0, 120.0] Stake length (mm)
let stake_w = 8.0; // [5.0, 12.0] Stake width (mm)
let stake_t = 3.0; // [2.0, 5.0] Stake thickness (mm)
// # Probe
let probe = 6.0; // [3.0, 10.0] Probe diameter (mm)
let clip_length = 15.0; // [8.0, 25.0] Clip length (mm)
let stake = polygon("XZ", [[-stake_w / 2.0, 0.0], [stake_w / 2.0, 0.0], [stake_w / 2.0, -length + 12.0], [0.0, -length], [-stake_w / 2.0, -length + 12.0]]).to_face().extrude([0, stake_t, 0]).translate([0, -stake_t / 2.0, 0]);
let rp = probe / 2.0 + 0.1;
let ro = rp + 1.8;
let cz = ro - 1.0;
let clip = cylinder([0, -clip_length / 2.0, cz], "Y", ro, clip_length) - cylinder([0, -clip_length, cz], "Y", rp, clip_length * 2.0) - box_from_corners([-probe * 0.375, -clip_length, cz], [probe * 0.375, clip_length, cz + ro + 1.0]);
let hook = box_from_corners([stake_w / 2.0 - 0.5, -stake_t / 2.0, -14.0], [stake_w / 2.0 + 5.0, stake_t / 2.0, -11.0]) + box_from_corners([stake_w / 2.0 + 2.0, -stake_t / 2.0, -11.01], [stake_w / 2.0 + 5.0, stake_t / 2.0, -7.0]);
stake + clip + hook
