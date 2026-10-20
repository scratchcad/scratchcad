// Folding motorcycle footpeg: 22 mm peg 100 mm long with a rounded end and 9 grip teeth on top, 10 mm thick clevis tongue 22 mm tall with an 8 mm pivot pin hole
let peg_d = 22.0; // [18.0, 30.0] Peg diameter (mm)
let peg_length = 100.0; // [70.0, 140.0] Peg length (mm)
let tongue_t = 10.0; // [6.0, 14.0] Tongue thickness (mm)
let pin_d = 8.0; // [6.0, 10.0] Pivot pin hole (mm)
let teeth = 9; // [0, 16] Number of grip teeth
const tongue_len = 24.0;
let r = peg_d / 2.0;
let x1 = tongue_len - 2.0;
let x2 = x1 + peg_length;
let prof = sketch("XY").move_to(x1, 0).vline_to(r).hline_to(x2 - r * 0.6).arc_to(x2 - r * 0.15, r * 0.6, x2, 0).close();
let peg = prof.to_face().revolve("X", 360);
let tongue = box_from_corners([0, -tongue_t / 2.0, -r], [tongue_len, tongue_t / 2.0, r]).fillet(r - 0.5, "|Y and <X");
let fp = peg + tongue;
let pitch = (peg_length - 20.0) / max(teeth, 1).to_float();
let cuts = [];
for i in 0..teeth {
    cuts.push(box_centered(3.0, peg_d + 2.0, 3.0).rotate_y(45.0).translate([x1 + 12.0 + (i.to_float() + 0.5) * pitch, 0, r]));
}
if teeth > 0 { fp = fp - compound(cuts); }
fp - cylinder([r * 0.5 + 1.0, -tongue_t, 0], "Y", pin_d / 2.0, tongue_t * 2.0)
