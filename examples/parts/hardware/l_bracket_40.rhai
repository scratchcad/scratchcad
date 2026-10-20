// Steel L-bracket 40 x 40 x 20 mm, 3 mm thick, with a 2 mm inner bend radius and two 5.5 mm holes per leg
let leg = 40.0; // [20.0, 120.0] Leg length (mm)
let width = 20.0; // [10.0, 60.0] Width (mm)
let thickness = 3.0; // [1.5, 8.0] Thickness (mm)
let bend_r = 2.0; // [0.5, 6.0] Inner bend radius (mm)
let hole = 5.5; // [3.0, 10.0] Hole diameter (mm)
let profile = sketch("XZ").move_to(0, leg).vline_to(bend_r + thickness).arc_to(bend_r + thickness - (bend_r + thickness) * 0.7071, bend_r + thickness - (bend_r + thickness) * 0.7071, bend_r + thickness, 0)
    .hline_to(leg).vline_to(thickness).hline_to(bend_r + thickness).arc_to(bend_r + thickness - bend_r * 0.7071, bend_r + thickness - bend_r * 0.7071, thickness, bend_r + thickness).vline_to(leg).close();
let bracket = profile.to_face().extrude([0, width, 0]);
for d in [leg * 0.45, leg * 0.8] {
    bracket -= cylinder([d, width / 2.0, -1], "Z", hole / 2.0, thickness + 2.0);
    bracket -= cylinder([-1, width / 2.0, d], "X", hole / 2.0, thickness + 2.0);
}
bracket
