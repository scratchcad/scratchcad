// Bronze acorn ground rod clamp for a 5/8 in (16 mm) rod: 28 mm acorn body 30 mm tall, 16.5 mm rod bore, 7 mm conductor slot across the side, 1/2 in square-head set screw boss
let rod_d = 16.0; // [12.0, 20.0] Ground rod diameter (mm)
let body_d = 28.0; // [24.0, 40.0] Body diameter (mm)
let height = 30.0; // [24.0, 40.0] Body height (mm)
let wire_d = 7.0; // [4.0, 10.0] Conductor diameter (mm)
let rb = body_d / 2.0;
let rr = min(rod_d, body_d - 8.0) / 2.0 + 0.25;
let body = sketch("XZ").move_to(0, 0).hline_to(rb - 3.0).line_to(rb, 4.0).vline_to(height * 0.6).arc_to(rb * 0.85, height * 0.85, rr + 2.5, height).hline_to(0).close().to_face().revolve("Z", 360);
let boss = cylinder([rb - 2.0, 0, height * 0.42], "X", 6.0, 6.0);
let head = box_centered(6.0, 12.7, 12.7).translate([rb + 7.0, 0, height * 0.42]).chamfer(1.0, "|X");
let c = fuse_all([body, boss, head]);
c -= cylinder([0, 0, -1], "Z", rr, height + 2.0);
c -= cylinder([-rb - 1.0, 0, height * 0.42], "X", 0.0 + wire_d / 2.0, 2.0 * rb + 2.0).translate([0, 0, 0]).rotate_z(90.0) & box_centered(4.0 * rb, 4.0 * rb, 4.0 * rb).translate([0, 0, height * 0.42]);
c
