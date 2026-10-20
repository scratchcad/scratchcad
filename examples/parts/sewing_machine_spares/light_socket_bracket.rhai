// Sewing light socket bracket: 2 mm steel angle, 20 mm wide, 24 mm upright with a 13 mm hole for the bulb socket, 16 mm foot with a 3.4 mm screw slot 6 mm long, 2 mm inside bend radius
let width = 20.0; // [16.0, 30.0] Bracket width (mm)
let upright = 24.0; // [18.0, 36.0] Upright height (mm)
let foot = 16.0; // [12.0, 24.0] Foot length (mm)
let socket_hole = 13.0; // [10.0, 15.0] Socket hole diameter (mm)
const t = 2.0;
const bend = 2.0;
let angle = sketch("XZ").move_to(0, 0).hline(foot).vline(t).hline_to(t + bend).arc_to(t + bend - bend * 0.7071, t + bend - bend * 0.7071, t, t + bend).vline_to(upright).hline_to(0).close();
let bracket = angle.to_face().extrude([0, width, 0]);
let hz = (t + bend + upright) / 2.0;
let hole_d = min(socket_hole, min(width - 4.0, upright - t - bend - 3.0));
let cuts = fuse_all([
    cylinder([-1.0, width / 2.0, hz], "X", hole_d / 2.0, t + 2.0),
    box_from_corners([foot - 11.0, width / 2.0 - 1.7, -1.0], [foot - 5.0, width / 2.0 + 1.7, t + 1.0]),
    cylinder([foot - 11.0, width / 2.0, -1.0], "Z", 1.7, t + 2.0),
    cylinder([foot - 5.0, width / 2.0, -1.0], "Z", 1.7, t + 2.0),
]);
bracket - cuts
