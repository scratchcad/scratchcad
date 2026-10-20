// Acorn finial: 45 mm acorn on a 30 mm collar, 10 mm dowel pin 15 mm, overall 95 mm
let d = 45.0; // [30.0, 70.0] Acorn diameter (mm)
let height = 95.0; // [60.0, 150.0] Height above the base (mm)
let pin = 10.0; // [6.0, 14.0] Dowel pin (mm)
let r = d / 2.0;
let p = sketch("XZ").move_to(0, 0).hline_to(r * 0.7).vline_to(6.0).hline_to(r * 0.5).vline_to(14.0).hline_to(r * 0.9).vline_to(height * 0.45).hline_to(r * 0.8).arc_to(r, height * 0.65, r * 0.4, height * 0.92).line_to(0.8, height).hline_to(0).close();
let body = p.face().revolve("Z", 360);
let cap_lines = [];
for k in 0..12 { cap_lines.push(box_centered(1.0, d, 8.0).translate([0, 0, height * 0.45 - 4.0 + 1.0]).rotate_z(k.to_float() * 15.0)); }
body - (fuse_all(cap_lines) - cylinder([0, 0, 0], "Z", r * 0.85, height)) + cylinder([0, 0, -15.0], "Z", pin / 2.0, 15.01)
