// Roof L-foot for PV rails: 4 mm aluminium angle 50 mm wide, 80 mm base with two 8.5 x 20 mm lag-screw slots, 75 mm upright with a 10.5 x 25 mm vertical rail-bolt slot
let width = 50.0; // [30.0, 70.0] Width (mm)
let base = 80.0; // [50.0, 120.0] Base length (mm)
let upright = 75.0; // [40.0, 120.0] Upright height (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
fn slot(len, w) {
    box_centered(len - w, w, 20.0) + cylinder([-(len - w) / 2.0, 0, -10], "Z", w / 2.0, 20.0) + cylinder([(len - w) / 2.0, 0, -10], "Z", w / 2.0, 20.0)
}
let ri = t;
let prof = sketch("XZ").move_to(0, 0).hline_to(base).vline_to(t).hline_to(t + ri)
    .arc_to(t + ri * (1.0 - 0.7071), t + ri * (1.0 - 0.7071), t, t + ri).vline_to(upright).hline_to(0).close();
let l = prof.to_face().extrude([0, width, 0]);
l -= slot(20.0, 8.5).translate([base * 0.5, width / 2.0, 0]);
l -= slot(20.0, 8.5).rotate_z(90.0).translate([base * 0.82, width / 2.0, 0]);
l -= slot(25.0, 10.5).rotate_y(90.0).translate([0, width / 2.0, upright * 0.62]);
l.fillet(2.0, "|X and >Z").fillet(2.0, "|Z and >X")
