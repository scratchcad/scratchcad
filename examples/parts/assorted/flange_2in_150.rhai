// ASME B16.5 2" Class 150 raised-face weld-neck flange
let flange_od = 152.4; // [100, 200] Flange outside diameter (mm)
let thickness = 19.1; // [12, 30] Flange thickness (mm)
let bolt_circle = 120.7; // [80, 170] Bolt circle diameter (mm)
let bolt_hole = 19.1; // [10, 25] Bolt hole diameter (mm)
let bolts = 4; // [4, 8] Number of bolts
let length = 62.0; // [40, 90] Overall length (mm)
let bore = 52.5; // [40, 60] Bore (mm)
let rf_d = 92.1; let rf_h = 1.6;
let hub_base = 78.0; let pipe_od = 60.3;
let profile = sketch("XZ").move_to(bore / 2.0, -rf_h)
    .hline_to(rf_d / 2.0).vline_to(0).hline_to(flange_od / 2.0).vline_to(thickness)
    .hline_to(hub_base / 2.0).line_to(pipe_od / 2.0, length - rf_h - 6.0).vline_to(length - rf_h)
    .hline_to(bore / 2.0).close();
let flange = profile.to_face().revolve("Z", 360);
for i in 0..bolts {
    let a = (i.to_float() + 0.5) * 360.0 / bolts.to_float();
    flange -= cylinder([bolt_circle / 2.0, 0, -5], "Z", bolt_hole / 2.0, thickness + 10).rotate_z(a);
}
flange
