// Raspberry Pi 4 Model B mounting base
let margin = 4.0; // [2.0, 15.0] Margin around the board (mm)
let plate_t = 3.0; // [2.0, 6.0] Plate thickness (mm)
let standoff_h = 6.0; // [3.0, 15.0] Standoff height (mm)
let standoff_d = 6.0; // [4.5, 8.0] Standoff diameter (mm)
let pilot_d = 2.2; // [1.8, 2.8] Screw pilot hole (mm)
let board_w = 85.0; let board_h = 56.0;
let pw = board_w + 2.0 * margin; let ph = board_h + 2.0 * margin;
let plate = box(pw, ph, plate_t).fillet(3.0, "|Z");
let holes = [];
for x in [3.5, 61.5] { for y in [3.5, 52.5] { holes.push([margin + x, margin + y]); } }
let parts = [plate];
for h in holes { parts.push(cylinder([h[0], h[1], plate_t - 0.1], "Z", standoff_d / 2.0, standoff_h + 0.1)); }
let base = fuse_all(parts);
for h in holes { base -= cylinder([h[0], h[1], 1.0], "Z", pilot_d / 2.0, plate_t + standoff_h); }
base
