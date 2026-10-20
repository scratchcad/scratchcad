// 2 ml autosampler vial, 12 x 32 mm, with a 9 mm short-thread (ND9) neck, and its screw cap with a 6 mm septum window, shown side by side
let vial_diameter = 11.6; // [10.0, 15.0] Vial diameter (mm)
let vial_height = 32.0; // [25.0, 45.0] Vial height (mm)
let glass = 1.0; // [0.6, 1.5] Glass wall thickness (mm)
let window = 6.0; // [3.0, 7.0] Septum window diameter (mm)
const pitch = 2.0;
const r_neck = 4.5;
const r_thread = 5.0;
let r = vial_diameter / 2.0;
let zs = vial_height - 6.5;
let profile = sketch("XZ")
    .move_to(0, 0)
    .hline_to(r - 1.0)
    .arc_to(r - 0.29, 0.29, r, 1.0)
    .vline_to(zs - 1.5)
    .line_to(r_neck, zs)
    .vline_to(vial_height - 0.3)
    .line_to(r_neck - 0.3, vial_height)
    .hline_to(3.0)
    .vline_to(zs)
    .line_to(r - glass, zs - 2.5)
    .vline_to(glass + 0.5)
    .arc_to(r - glass - 0.15, glass + 0.15, r - glass - 0.5, glass)
    .hline_to(0)
    .close();
let vial = profile.to_face().revolve("Z", 360);
let section = polygon([[r_neck - 0.2, 0, -0.55], [r_thread, 0, -0.2], [r_thread, 0, 0.2], [r_neck - 0.2, 0, 0.55]]);
let sections = [];
for i in 0..=12 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, zs + 1.5 + t * pitch]));
}
vial = vial + loft(sections, true);
// cap: 7 mm skirt, internal thread, septum window in the top
let rci = r_thread + 0.15;
let cap = cylinder(rci + 0.9, 7.0).fillet(0.4, ">Z") - cylinder([0, 0, -1], "Z", rci, 7.0) - cylinder([0, 0, 5.0], "Z", min(window / 2.0, rci - 0.5), 3.0);
let csec = polygon([[rci + 0.2, 0, -0.55], [r_neck + 0.15, 0, -0.2], [r_neck + 0.15, 0, 0.2], [rci + 0.2, 0, 0.55]]);
let csections = [];
for i in 0..=12 {
    let t = i.to_float() / 12.0;
    csections.push(csec.rotate_z(-t * 360.0).translate([0, 0, 4.0 - t * pitch]));
}
cap = cap + loft(csections, true);
[vial, cap.translate([vial_diameter + 6.0, 0, 0])]
