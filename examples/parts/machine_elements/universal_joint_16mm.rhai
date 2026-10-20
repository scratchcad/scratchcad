// Single Cardan universal joint for 16 mm shafts: two forked yokes on 28 mm hubs 22 mm long, a 6 mm journal cross 24 mm tip to tip, 4 mm cross pins, M5 set screws
let bore = 16.0; // [6.0, 25.0] Shaft bore (mm)
let hub_diameter = 28.0; // [14.0, 45.0] Hub diameter (mm)
let hub_length = 22.0; // [10.0, 40.0] Hub length (mm)
let cross_span = 24.0; // [14.0, 40.0] Cross tip to tip (mm)
let journal = 6.0; // [3.0, 10.0] Journal diameter (mm)
let rh = max(hub_diameter / 2.0, bore / 2.0 + 3.0);
let half = cross_span / 2.0;
const ear_t = 3.5;
let core = journal * 1.4;
fn yoke(rh, hub_length, bore, half, ear_t, journal) {
    let ear_in = half - ear_t;
    let hub = cylinder([0, 0, -hub_length - rh * 0.6], "Z", rh, hub_length);
    let fork = box_from_corners([-half, -rh * 0.7, -rh * 0.6 - 0.01], [half, rh * 0.7, 0]) + cylinder([-half, 0, 0], "X", rh * 0.7, 2.0 * half);
    fork = fork - box_from_corners([-ear_in, -rh, -rh * 0.6 + 2.0], [ear_in, rh, rh]);
    fork = fork - cylinder([-half - 1.0, 0, 0], "X", journal / 2.0 + 0.05, 2.0 * half + 2.0);
    let y = hub + fork;
    y = y - cylinder([0, 0, -hub_length - rh * 0.6 - 1.0], "Z", bore / 2.0, hub_length + 1.0 + 0.5);
    y - cylinder([0, 0, -hub_length * 0.5 - rh * 0.6], "Y", 2.1, rh + 1.0)
}
let lower = yoke(rh, hub_length, bore, half, ear_t, journal);
let upper = lower.rotate("Z", 90.0).mirror("XY");
let cross = fuse_all([box_centered(core, core, core), cylinder([-half, 0, 0], "X", journal / 2.0, cross_span), cylinder([0, -half, 0], "Y", journal / 2.0, cross_span)]);
compound([lower, cross, upper])
