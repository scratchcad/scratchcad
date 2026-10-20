// Walker ski glide for 25 mm (1 in) legs: 110 x 30 mm ski with an upturned toe, 32 mm socket 35 mm tall with a push-button hole and set-screw boss
let leg_diameter = 25.4; // [19.0, 32.0] Walker leg diameter (mm)
let ski_length = 110.0; // [80.0, 160.0] Ski length (mm)
let ski_width = 30.0; // [22.0, 45.0] Ski width (mm)
let socket_height = 35.0; // [20.0, 50.0] Socket height (mm)
let rl = leg_diameter / 2.0 + 0.3;
let rs = rl + 3.0;
let hw = max(ski_width / 2.0, rs);
let L = ski_length;
let ski = sketch("XZ").move_to(-L * 0.4, 0).hline_to(L * 0.45).arc_to(L * 0.55, 3.0, L * 0.6, 12.0).hline(-6.0).arc_to(L * 0.5, 6.0, L * 0.45, 6.0)
    .hline_to(-L * 0.4 + 3.0).arc_to(-L * 0.4 + 0.8, 5.2, -L * 0.4, 3.0).close().to_face().extrude([0, ski_width, 0]).translate([0, -ski_width / 2.0, 0]);
let socket = cylinder([0, 0, 5.0], "Z", rs, socket_height).chamfer(1.0, ">Z");
let boss = cylinder([0, 0, 5.0 + socket_height * 0.5], "X", 5.0, rs + 3.0);
let glide = fuse_all([ski, socket, boss]);
glide -= cylinder([0, 0, 7.0], "Z", rl, socket_height + 1.0);
glide -= cylinder([0, 0, 5.0 + socket_height * 0.5], "X", 2.0, rs + 5.0);
glide - cylinder([0, -rs - 1.0, 5.0 + socket_height * 0.7], "Y", 3.5, 2.0 * rs + 2.0)
