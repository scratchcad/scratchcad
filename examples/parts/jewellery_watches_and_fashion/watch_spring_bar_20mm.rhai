// Watch spring bar for 20 mm lugs: 1.5 mm tube 17.4 mm long with 1.8 mm shoulder flanges near each end, 0.8 mm tips 1.2 mm long (21.4 mm tip to tip extended)
let lug_width = 20.0; // [10.0, 28.0] Lug width (mm)
let tube_diameter = 1.5; // [1.1, 2.0] Tube diameter (mm)
let tip_diameter = 0.8; // [0.6, 1.1] Tip diameter (mm)
let tip_length = 1.2; // [0.6, 2.0] Tip length (mm)
let rt = tube_diameter / 2.0;
let rp = min(tip_diameter / 2.0, rt - 0.15);
let half = lug_width / 2.0 - 0.6;
let tip_end = half + tip_length + 0.1;
// half profile in the XY plane, revolved about X
let profile = sketch("XY")
    .move_to(-tip_end, 0)
    .vline_to(rp - 0.1)
    .line_to(-tip_end + 0.1, rp)
    .hline_to(-half)
    .vline_to(rt)
    .hline_to(-half + 0.3)
    .vline_to(rt + 0.15)
    .hline_to(-half + 0.8)
    .vline_to(rt)
    .hline_to(half - 0.8)
    .vline_to(rt + 0.15)
    .hline_to(half - 0.3)
    .vline_to(rt)
    .hline_to(half)
    .vline_to(rp)
    .hline_to(tip_end - 0.1)
    .line_to(tip_end, rp - 0.1)
    .vline_to(0)
    .close();
profile.to_face().revolve("X", 360)
