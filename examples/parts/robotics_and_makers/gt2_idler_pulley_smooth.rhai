// Smooth GT2 belt idler: 18 mm flanges, 12 mm running surface 8.5 mm wide for 6 mm belt, 10 mm bore for two stacked 623ZZ bearings (3 x 10 x 4 mm) with a centre spacer lip
let flange_d = 18.0; // [14.0, 25.0] Flange diameter (mm)
let run_d = 12.0; // [10.0, 20.0] Running surface diameter (mm)
let belt_w = 8.5; // [6.5, 11.0] Width between flanges (mm)
let bearing_od = 10.0; // [7.0, 16.0] Bearing outside diameter (mm)
const flange_t = 1.0;
let rf = max(flange_d, run_d + 3.0) / 2.0;
let rr = max(run_d, bearing_od + 1.5) / 2.0;
let w = belt_w + 2.0 * flange_t;
let p = sketch("XZ").move_to(0, 0).hline_to(rf).vline_to(flange_t).line_to(rr, flange_t + 0.6).vline_to(w - flange_t - 0.6).line_to(rf, w - flange_t).vline_to(w).hline_to(0).close().to_face().revolve("Z", 360);
p -= cylinder([0, 0, -1], "Z", bearing_od / 2.0, w + 2.0);
let lip = cylinder([0, 0, w / 2.0 - 0.4], "Z", bearing_od / 2.0 + 0.01, 0.8) - cylinder([0, 0, w / 2.0 - 1.0], "Z", bearing_od / 2.0 - 1.0, 2.0);
p + lip
