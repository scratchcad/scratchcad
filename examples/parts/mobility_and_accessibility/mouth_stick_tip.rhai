// Mouth stick tip: replaceable tip for a 6 mm dowel mouth stick, 10 mm diameter x 30 mm body with a 15 mm socket, 8 mm domed stylus end with a 3 mm page-turning hook notch
// # Fit
let dowel = 6.0; // [4.0, 10.0] Stick diameter (mm)
let socket_depth = 15.0; // [8.0, 20.0] Socket depth (mm)
// # Tip
let body_d = 10.0; // [8.0, 16.0] Tip body diameter (mm)
let length = 30.0; // [22.0, 45.0] Tip length (mm)
let r = max(body_d / 2.0, dowel / 2.0 + 1.5);
let body = sketch("XZ").move_to(0, 0).hline_to(r).vline(length - 8.0).line_to(r * 0.8, length - 3.0).line_to(r * 0.4, length).hline_to(0).close().to_face().revolve("Z", 360);
let socket = cylinder([0, 0, -1.0], "Z", dowel / 2.0 + 0.1, min(socket_depth, length - 10.0) + 1.0);
let notch = box_from_corners([r - 3.0, -r - 1.0, length - 14.0], [r + 1.0, r + 1.0, length - 11.0]).rotate([r, 0, length - 12.5], "Y", -20.0);
body - socket - notch
