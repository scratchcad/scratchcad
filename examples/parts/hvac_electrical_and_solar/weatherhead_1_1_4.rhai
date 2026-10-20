// Service entrance weatherhead for 1-1/4 in conduit: cast aluminium hood 90 mm diameter, 60 mm tall, 42 mm threaded hub, insulator disc underneath with three 14 mm conductor holes
let hood_d = 90.0; // [60.0, 140.0] Hood diameter (mm)
let height = 60.0; // [40.0, 90.0] Overall height (mm)
let hub_d = 48.0; // [30.0, 70.0] Hub outside diameter (mm)
let conduit_d = 42.2; // [21.0, 60.0] Conduit outside diameter (mm)
let wire_hole = 14.0; // [8.0, 20.0] Conductor hole diameter (mm)
const t = 3.0;
let rh = hood_d / 2.0;
let cd = min(conduit_d, hub_d - 6.0);
let dome = sketch("XZ").move_to(0, 0).hline_to(rh).vline_to(10.0).arc_to(rh * 0.8, height * 0.55, rh * 0.35, height * 0.75).hline_to(0).close().to_face().revolve("Z", 360);
let inside = sketch("XZ").move_to(0, -1).hline_to(rh - t).vline_to(10.0).arc_to(rh * 0.8 - t, height * 0.55 - t, rh * 0.35, height * 0.75 - t).hline_to(0).close().to_face().revolve("Z", 360);
let hood = dome - inside;
let hub = cylinder([0, 0, height * 0.75 - t - 1.0], "Z", hub_d / 2.0, height * 0.25 + t + 1.0).rotate([0, 0, height * 0.75], "Y", 0.0);
let w = fuse_all([hood, hub]) - cylinder([0, 0, height * 0.75 - t - 2.0], "Z", cd / 2.0, height);
let disc = cylinder([0, 0, 2.0], "Z", rh - t + 0.1, 4.0);
let wh = min(wire_hole, hood_d / 6.0);
for i in 0..3 { disc -= cylinder([rh * 0.5, 0, 0], "Z", wh / 2.0, 10.0).rotate_z(i.to_float() * 120.0); }
disc -= cylinder([0, 0, 0], "Z", 2.5, 10.0);
fuse_all([w, disc])
