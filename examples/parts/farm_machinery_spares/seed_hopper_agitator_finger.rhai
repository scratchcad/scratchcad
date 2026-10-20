// Seed hopper agitator finger for a 1/2 inch hex shaft: 24 mm hub 10 mm wide with a 12.9 mm across-flats hex bore, a 4.2 mm set screw hole into one flat, and a finger 40 mm long tapering from 8 to 4 mm wide, 5 mm thick, with a rounded tip
let hex_af = 12.9; // [9.6, 19.3] Hex bore across flats (mm)
let hub_d = 24.0; // [18.0, 34.0] Hub diameter (mm)
let hub_w = 10.0; // [8.0, 16.0] Hub width (mm)
let finger_len = 40.0; // [25.0, 70.0] Finger length (mm)
const root_w = 8.0;
const tip_w = 4.0;
const finger_t = 5.0;
const screw = 4.2;
let rh = max(hub_d / 2.0, hex_af / 2.0 / cos(30.0 * PI() / 180.0) + 3.5);
let rx = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let hub = cylinder([0, -hub_w / 2.0, 0], "Y", rh, hub_w);
let x1 = rh + finger_len;
let finger = polygon([[rh - 2.0, -finger_t / 2.0, -root_w / 2.0], [x1, -finger_t / 2.0, -tip_w / 2.0], [x1, -finger_t / 2.0, tip_w / 2.0], [rh - 2.0, -finger_t / 2.0, root_w / 2.0]]).to_face().extrude([0, finger_t, 0]);
let finger = finger + cylinder([x1 - 0.5, -finger_t / 2.0, 0], "Y", tip_w / 2.0, finger_t);
let hex = polygon("XZ", [30, 90, 150, 210, 270, 330].map(|a| [rx * cos(a * PI() / 180.0), rx * sin(a * PI() / 180.0)])).to_face().extrude([0, hub_w + 2.0, 0]).translate([0, -hub_w / 2.0 - 1.0, 0]);
(hub + finger) - hex - cylinder([0, 0, 0], "-X", screw / 2.0, rh + 1.0)
