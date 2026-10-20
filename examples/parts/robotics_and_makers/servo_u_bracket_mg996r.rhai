// Multi-purpose U bracket for MG996R / standard servos (40.7 x 19.7 mm body): 2.5 mm aluminium, 57 x 24 mm base, 45 mm arms, 25T horn pattern (8 mm centre, four M3 on 14 mm circle) on one arm and an M3 idler bearing hole on the other
let inner_w = 57.0; // [45.0, 70.0] Inside width between arms (mm)
let width = 24.0; // [18.0, 32.0] Bracket width (mm)
let arm_h = 45.0; // [30.0, 60.0] Arm height (mm)
let t = 2.5; // [1.5, 4.0] Sheet thickness (mm)
let hw = inner_w / 2.0 + t;
let prof = sketch("XZ").move_to(-hw, arm_h).vline_to(t * 2.0).arc_to(-hw + t * 0.586, t * 0.586, -hw + 2.0 * t, 0).hline_to(hw - 2.0 * t)
    .arc_to(hw - t * 0.586, t * 0.586, hw, t * 2.0).vline_to(arm_h).hline_to(hw - t).vline_to(t * 2.0).arc_to(hw - t - 0.293 * t, t + 0.293 * t, hw - 2.0 * t, t)
    .hline_to(-hw + 2.0 * t).arc_to(-hw + t + 0.293 * t, t + 0.293 * t, -hw + t, t * 2.0).vline_to(arm_h).close();
let u = prof.to_face().extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let top = width / 2.0;
let cap = box_from_corners([-hw - 2.0, -top, arm_h - 0.01], [hw + 2.0, top, arm_h + top]);
u += (cylinder([-hw, 0, arm_h], "X", top, t) & cap) + (cylinder([hw - t, 0, arm_h], "X", top, t) & cap);
let zc = arm_h;
u -= cylinder([-hw - 1.0, 0, zc], "X", 4.0, t + 2.0);
for i in 0..4 { u -= cylinder([-hw - 1.0, 7.0, 0], "X", 1.6, t + 2.0).rotate_x(i.to_float() * 90.0 + 45.0).translate([0, 0, zc]); }
u -= cylinder([hw - t - 1.0, 0, zc], "X", 1.6, t + 2.0);
for x in [-15.0, 0.0, 15.0] { u -= cylinder([x, 0, -1], "Z", 1.6, t + 2.0); }
for x in [-1.0, 1.0] { u -= cylinder([x * 7.5, 7.0, -1], "Z", 1.6, t + 2.0) + cylinder([x * 7.5, -7.0, -1], "Z", 1.6, t + 2.0); }
u
