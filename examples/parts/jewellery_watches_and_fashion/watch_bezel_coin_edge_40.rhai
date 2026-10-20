// Rotating dive-watch bezel, 40 mm: 32 mm bore, 3 mm tall, 120-click coin-edge grip, top sloping inwards, 12 recessed hour markers 1 mm across
let outer_diameter = 40.0; // [32.0, 48.0] Outer diameter (mm)
let inner_diameter = 32.0; // [24.0, 40.0] Inner diameter (mm)
let height = 3.0; // [2.0, 5.0] Height (mm)
let serrations = 120; // [0, 180] Number of coin-edge serrations
let marker_diameter = 1.0; // [0.5, 2.0] Marker diameter (mm)
let ro = outer_diameter / 2.0;
let ri = min(inner_diameter / 2.0, ro - 2.5);
let profile = sketch("XZ")
    .move_to(ri, 0)
    .hline_to(ro)
    .vline_to(height - 0.8)
    .line_to(ro - 0.8, height)
    .line_to(ri + 0.5, height - 0.4)
    .line_to(ri, height - 0.4)
    .close();
let bezel = profile.to_face().revolve("Z", 360);
let cuts = [];
for i in 0..serrations {
    cuts.push(cylinder([ro + 0.12, 0, -1], "Z", 0.28, height - 0.8 + 1.0).rotate_z(i.to_float() * 360.0 / serrations.to_float()));
}
let rm = (ro - 0.8 + ri + 0.5) / 2.0;
for i in 0..12 {
    cuts.push(cylinder([rm, 0, height - 0.6], "Z", marker_diameter / 2.0, 2.0).rotate_z(i.to_float() * 30.0));
}
bezel - compound(cuts)
