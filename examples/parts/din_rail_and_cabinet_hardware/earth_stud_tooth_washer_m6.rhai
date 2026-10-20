// External tooth contact washer for an M6 cabinet earth stud: 6.4 mm bore, 11 mm over the teeth, 0.7 mm thick, 10 teeth with 1.2 mm deep gaps, for bonding through paint
let stud = 6.0; // [4.0, 12.0] Stud size (mm)
let teeth = 10; // [6, 18] Number of teeth
let thickness = 0.7; // [0.5, 1.2] Washer thickness (mm)
let bore = stud + 0.4;
let r_out = stud * 0.92 + 0.0;
let r_root = r_out - 1.2;
let pts = [];
let n = teeth * 4;
for i in 0..n {
    let a = i.to_float() * 360.0 / n.to_float() * PI() / 180.0;
    let r = if (i % 4) < 2 { r_out } else { r_root };
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let w = face(polygon(pts)).extrude([0, 0, thickness]);
w - cylinder([0, 0, -1.0], "Z", bore / 2.0, thickness + 2.0)
