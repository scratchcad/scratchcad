// 58 mm centre-pinch lens cap: 60.5 mm face, 6.5 mm deep, two spring latches that catch the M58 filter thread, finger recess with ribbed pinch pads
let thread_size = 58.0; // [37.0, 82.0] Filter thread it fits (mm)
let face_thickness = 1.8; // [1.2, 3.0] Face thickness (mm)
let depth = 6.5; // [4.0, 10.0] Cap depth (mm)
let latch_width = 14.0; // [8.0, 20.0] Latch width (mm)
let r_in = thread_size / 2.0 - 0.6;
let r_face = thread_size / 2.0 + 1.25;
// face plate with a rounded rim
let face = cylinder(r_face, face_thickness).fillet(0.8, "%CIRCLE and >Z");
// skirt that sits inside the filter thread
let zb = face_thickness - depth;
let skirt = cylinder([0, 0, zb], "Z", r_in, 0.1 - zb) - cylinder([0, 0, zb - 1.0], "Z", r_in - 1.2, 1.0 - zb);
let cap = face + skirt;
// two latch tongues cut free on three sides, each with a catch that springs into the thread
for a in [0.0, 180.0] {
    let slots = box_from_corners([r_in - 2.0, -latch_width / 2.0 - 0.8, zb - 1.0], [r_in + 1.0, -latch_width / 2.0, -0.5])
        + box_from_corners([r_in - 2.0, latch_width / 2.0, zb - 1.0], [r_in + 1.0, latch_width / 2.0 + 0.8, -0.5]);
    cap -= slots.rotate_z(a);
    let latch_catch = polygon("XZ", [[r_in - 0.1, zb + 0.8], [r_in + 0.7, zb + 1.6], [r_in + 0.7, zb + 2.4], [r_in - 0.1, zb + 2.8]]).to_face()
        .extrude([0, latch_width - 1.0, 0]).translate([0, -(latch_width - 1.0) / 2.0, 0]);
    cap += latch_catch.rotate_z(a);
}
// finger recess across the face with pinch ribs
let recess = box_centered(r_in * 1.2, 16.0, 2.0).translate([0, 0, face_thickness + 0.4]);
cap -= recess.rotate_z(90.0);
for x in [-1.0, 1.0] {
    for k in 0..4 {
        cap += box_centered(1.0, 12.0, 0.6).translate([x * (r_in * 0.6 - 0.8 * k.to_float() * 1.6 - 1.0), 0, face_thickness - 0.35]).rotate_z(90.0);
    }
}
cap
