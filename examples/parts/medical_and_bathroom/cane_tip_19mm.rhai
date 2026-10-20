// Walking cane rubber tip for a 19 mm (3/4 in) shaft: 38 mm tread base, 45 mm tall, 35 mm deep socket with a steel washer insert, concentric tread rings
let shaft_diameter = 19.0; // [14.0, 25.0] Cane shaft diameter (mm)
let base_diameter = 38.0; // [28.0, 55.0] Base diameter (mm)
let height = 45.0; // [30.0, 60.0] Tip height (mm)
let socket_depth = 35.0; // [20.0, 45.0] Socket depth (mm)
let rs = shaft_diameter / 2.0 + 0.2;
let rt = rs + 3.5;
let rb = max(base_diameter / 2.0, rt + 2.0);
let d = min(socket_depth, height - 6.0);
let tip = sketch("XZ").move_to(0, 0).hline_to(rb - 2.0).arc_to(rb - 0.6, 0.6, rb, 2.0).vline_to(6.0).line_to(rt, 16.0)
    .vline_to(height - 1.5).line_to(rt - 1.5, height).hline_to(0).close().to_face().revolve("Z", 360);
for i in 0..3 {
    tip -= torus(rb * (0.3 + 0.22 * i.to_float()), 0.9);
}
tip -= cylinder([0, 0, height - d], "Z", rs, d + 1.0);
let washer = cylinder([0, 0, height - d + 0.05], "Z", rs - 0.3, 1.5) - cylinder([0, 0, height - d - 1.0], "Z", 3.0, 4.0);
compound([tip, washer])
