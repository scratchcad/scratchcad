// Prize rosette badge back: 45 mm disc 2 mm thick with a 15 mm ribbon-tail bar slot and a 25 mm safety-pin boss pair 4 mm tall with 1.2 mm pin holes
let dia = 45.0; // [35.0, 60.0] Disc diameter (mm)
let pin_span = 25.0; // [18.0, 35.0] Pin boss spacing (mm)
const t = 2.0;
let d = cylinder([0, 0, 0], "Z", dia / 2.0, t);
let bosses = box_centered(4.0, 5.0, 4.0).translate([-pin_span / 2.0, 0, t + 2.0 - 0.01]) + box_centered(4.0, 5.0, 4.0).translate([pin_span / 2.0, 0, t + 2.0 - 0.01]);
d + bosses - cylinder([-pin_span, 0, t + 2.5], "X", 0.6, 2.0 * pin_span) - box_centered(15.0, 3.0, t + 2.0).translate([0, -dia / 2.0 + 6.0, t / 2.0])
