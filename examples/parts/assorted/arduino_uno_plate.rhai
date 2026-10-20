// Arduino Uno R3 mounting plate
let margin = 5.0; // [2.0, 15.0] Margin around the board (mm)
let plate_t = 3.0; // [2.0, 6.0] Plate thickness (mm)
let standoff_h = 5.0; // [3.0, 12.0] Standoff height (mm)
let hole_d = 3.2; // [2.5, 3.5] Hole diameter (mm)
let pw = 68.6 + 2.0 * margin; let ph = 53.4 + 2.0 * margin;
let holes = [[13.97, 2.54], [15.24, 50.8], [66.04, 7.62], [66.04, 35.56]];
let parts = [box(pw, ph, plate_t).fillet(3.0, "|Z")];
for h in holes { parts.push(cylinder([margin + h[0], margin + h[1], plate_t - 0.1], "Z", 3.0, standoff_h + 0.1)); }
let plate = fuse_all(parts);
for h in holes { plate -= cylinder([margin + h[0], margin + h[1], -1.0], "Z", hole_d / 2.0, plate_t + standoff_h + 2.0); }
plate
