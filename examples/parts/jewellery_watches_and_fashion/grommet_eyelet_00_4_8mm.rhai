// Size #00 grommet set for fabric: eyelet with a 4.8 mm hole, 6 mm barrel 4.5 mm long and 11 mm flange, plus its 11 mm coned washer shown 1 mm above the barrel
let hole_diameter = 4.8; // [3.0, 12.0] Hole diameter (mm)
let flange_diameter = 11.0; // [7.0, 25.0] Flange diameter (mm)
let barrel_length = 4.5; // [2.5, 8.0] Barrel length (mm)
let sheet = 0.45; // [0.3, 0.8] Metal thickness (mm)
let rh = hole_diameter / 2.0;
let rbo = rh + sheet;
let rf = max(flange_diameter / 2.0, rbo + 1.5);
// eyelet: flange curling up into the barrel
let eyelet_profile = sketch("XZ")
    .move_to(rh, 0)
    .hline_to(rf - 0.3)
    .arc_to(rf, sheet * 0.5 + 0.15, rf - 0.3, sheet + 0.3)
    .line_to(rbo + 0.6, sheet + 0.15)
    .arc_to(rbo + 0.1, sheet + 0.35, rbo, sheet + 0.8)
    .vline_to(barrel_length)
    .hline_to(rh)
    .close();
let eyelet = eyelet_profile.to_face().revolve("Z", 360);
// washer: coned ring with a hole that clears the barrel
let zw = barrel_length + 1.0;
let rw = rbo + 0.15;
let washer_profile = sketch("XZ")
    .move_to(rw, zw + 0.8)
    .line_to(rf, zw)
    .vline_to(zw + sheet)
    .line_to(rw, zw + 0.8 + sheet)
    .close();
let washer = washer_profile.to_face().revolve("Z", 360);
[eyelet, washer]
