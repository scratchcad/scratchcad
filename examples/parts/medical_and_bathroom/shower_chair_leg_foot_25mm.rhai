// Shower chair rubber leg foot for 25 mm tubes: 40 mm base 30 mm tall, 22 mm socket, concave suction underside, eight radial anti-slip ribs
let tube_diameter = 25.0; // [19.0, 32.0] Leg tube diameter (mm)
let base_diameter = 40.0; // [30.0, 55.0] Base diameter (mm)
let height = 30.0; // [20.0, 45.0] Foot height (mm)
let socket_depth = 22.0; // [12.0, 30.0] Socket depth (mm)
let rt = tube_diameter / 2.0 + 0.2;
let ro = rt + 3.0;
let rb = max(base_diameter / 2.0, ro + 3.0);
let foot = sketch("XZ").move_to(0, 0).hline_to(rb).vline_to(4.0).arc_to(ro + (rb - ro) * 0.3, 9.0, ro, 15.0).vline_to(height).hline_to(0).close().to_face().revolve("Z", 360);
let d = min(socket_depth, height - 6.0);
foot -= cylinder([0, 0, height - d], "Z", rt, d + 1.0);
foot -= sphere([0, 0, -rb * 1.4 + 2.5], rb * 1.4) & cylinder([0, 0, -1.0], "Z", rb - 3.0, 5.0);
let ribs = [];
for i in 0..8 {
    ribs.push(box_from_corners([rb - 3.0, -1.0, -0.1], [rb, 1.0, 1.0]).rotate_z(i.to_float() * 45.0 + 22.5));
}
foot - compound(ribs)
