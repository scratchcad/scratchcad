// Swingarm paddock stand spool M8x1.25: 25 mm flanges, 14 mm core 7 mm wide groove with 12 mm wrench flats, 15 mm M8 stud
let flange_d = 25.0; // [20.0, 32.0] Flange diameter (mm)
let core_d = 14.0; // [10.0, 18.0] Groove core diameter (mm)
let groove = 7.0; // [5.0, 10.0] Groove width (mm)
let stud_length = 15.0; // [10.0, 25.0] Stud length (mm)
let thread_d = 8.0; // [6.0, 10.0] Thread size (mm)
let pitch = 1.25; // [1.0, 1.5] Thread pitch (mm)
const base_t = 3.0;
const cap_t = 5.0;
let rf = flange_d / 2.0;
let top = base_t + groove + cap_t;
let prof = sketch("XZ").move_to(0, 0).hline_to(rf - 0.5).line_to(rf, 0.5).vline_to(base_t).hline_to(core_d / 2.0).vline_to(base_t + groove)
    .hline_to(rf).vline_to(top - 1.5).line_to(rf - 1.5, top).hline_to(0).close();
let spool = prof.to_face().revolve("Z", 360);
let flat = core_d / 2.0 - 1.0;
for s in [-1.0, 1.0] {
    spool = spool - box_from_corners([s * flat, -rf, base_t], [s * (rf + 1.0), rf, base_t + groove]);
}
let r_major = thread_d / 2.0;
let r_minor = r_major - 0.613 * pitch;
let sp = [[0.0, 0.5], [r_minor, 0.5], [r_minor, -0.5]];
let turns = ((stud_length - 1.5) / pitch).floor().to_int();
for i in 0..turns {
    sp.push([r_major, -0.5 - (i.to_float() + 0.5) * pitch]);
    sp.push([r_minor, -0.5 - (i.to_float() + 1.0) * pitch]);
}
sp.push([r_minor, -stud_length + 0.4]);
sp.push([r_minor - 0.4, -stud_length]);
sp.push([0.0, -stud_length]);
spool + polygon("XZ", sp).to_face().revolve("Z", 360)
