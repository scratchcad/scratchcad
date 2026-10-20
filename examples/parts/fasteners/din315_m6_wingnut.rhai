// DIN 315 M6 wing nut: 32 mm wing span, 16 mm tall, 12 mm hub
let span = 32.0; // [20.0, 60.0] Wing span (mm)
let height = 16.0; // [10.0, 32.0] Height (mm)
let hub_d = 12.0; // [8.0, 24.0] Hub diameter (mm)
let hub_h = 7.0; // [4.0, 14.0] Hub height (mm)
let wing_t = 2.5; // [1.5, 5.0] Wing thickness (mm)
let bore = 5.0; // [2.5, 10.4] Bore (mm)
let hub = cone(hub_d / 2.0, hub_d * 0.4, hub_h);
let wing = sketch("XZ").move_to(hub_d * 0.3, 0).line_to(span / 2.0 - 2.0, hub_h * 0.4)
    .arc_to(span / 2.0, height * 0.75, span / 2.0 - 3.0, height).line_to(hub_d * 0.3, hub_h).close()
    .to_face().extrude([0, wing_t, 0]).translate([0, -wing_t / 2.0, 0]);
fuse_all([hub, wing, wing.rotate_z(180)]) - cylinder([0, 0, -1], "Z", bore / 2.0, hub_h + 2.0)
