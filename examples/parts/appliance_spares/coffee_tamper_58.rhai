// Espresso tamper, 58 mm flat base: 58 mm x 12 mm piston, 25 mm waist, 40 mm ball handle, 90 mm tall
let base = 58.0; // [49.0, 59.0] Base diameter (mm)
let height = 90.0; // [70.0, 110.0] Overall height (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(base / 2.0).vline_to(10.0).arc_to(base / 2.0 - 1.0, 11.5, base / 2.0 - 3.0, 12.0).hline_to(14.0).arc_to(11.0, 30.0, 12.5, 48.0).arc_to(21.0, 68.0, 6.0, height - 1.0).line_to(0, height).close();
p.face().revolve("Z", 360)
