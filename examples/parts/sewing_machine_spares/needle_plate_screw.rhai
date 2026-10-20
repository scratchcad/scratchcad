// Needle plate screw: 90 degree countersunk head 6 mm across 1.7 mm deep with a 0.8 x 6 mm slot 0.9 mm deep, M3 shank (plain 3 mm cylinder) 5 mm long with a 0.3 mm lead-in chamfer
let head_d = 6.0; // [5.0, 8.0] Head diameter (mm)
let shank_d = 3.0; // [2.5, 4.0] Shank diameter (mm)
let shank_len = 5.0; // [3.0, 10.0] Shank length (mm)
let slot_w = 0.8; // [0.6, 1.2] Slot width (mm)
let rh = max(head_d / 2.0, shank_d / 2.0 + 1.0);
let rs = shank_d / 2.0;
let hh = rh - rs + 0.2;
let profile = polygon([
    [0, 0, 0], [rs - 0.3, 0, 0], [rs, 0, 0.3], [rs, 0, shank_len], [rh, 0, shank_len + hh - 0.2], [rh, 0, shank_len + hh], [0, 0, shank_len + hh]
]);
let screw = profile.to_face().revolve("Z", 360.0);
screw - box_centered(2.0 * rh + 2.0, slot_w, 1.8).translate([0, 0, shank_len + hh])
