// Salt shaker: 45 mm barrel body 70 mm tall with 2 mm walls and a 30 mm screw neck (shown as a band), 34 mm domed cap with five 1.5 mm holes; cap shown lifted 5 mm
let body_diameter = 45.0; // [30.0, 70.0] Body diameter (mm)
let body_height = 70.0; // [40.0, 120.0] Body height to the neck (mm)
let wall = 2.0; // [1.2, 3.0] Wall thickness (mm)
let neck_diameter = 30.0; // [20.0, 40.0] Neck diameter (mm)
let hole_diameter = 1.5; // [1.0, 3.0] Pour hole diameter (mm)
let cap_lift = 5.0; // [0.0, 20.0] Cap lifted for display (mm)
let r = body_diameter / 2.0;
let rn = min(neck_diameter / 2.0, r - 3.0);
let h = body_height;
let p = sketch("XZ").move_to(0, 0).hline_to(r - 3.0).arc_to(r - 0.6, 1.5, r, 5.0).arc_to(r + 1.5, h * 0.5, r, h - 8.0)
    .arc_to(r - 2.5, h - 2.5, rn, h).vline(10.0).hline_to(0).close();
let body = p.to_face().revolve("Z", 360).shell(-wall, ">Z");
let zc = h + 10.0 + cap_lift;
let cap = sketch("XZ").move_to(0, zc - 11.0).hline_to(rn + 2.0).vline_to(zc + 1.0).arc_to(rn * 0.7, zc + 5.0, 0, zc + 6.0).close().to_face().revolve("Z", 360);
cap -= cylinder([0, 0, zc - 12.0], "Z", rn + 0.2, 13.0);
let holes = [cylinder([0, 0, zc], "Z", hole_diameter / 2.0, 8.0)];
for i in 0..4 {
    holes.push(cylinder([5.0, 0, zc], "Z", hole_diameter / 2.0, 8.0).rotate_z(i.to_float() * 90.0));
}
compound([body, cap - compound(holes)])
