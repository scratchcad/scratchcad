// PET bottle preform with a 28 mm PCO 1881 style neck: 27.4 mm thread diameter (T), 25.1 mm root (E), 21.7 mm bore, 2.7 mm pitch, 33 mm support ring, tamper bead, 24.4 mm body with 3.2 mm wall and a hemispherical end, 95 mm long
let total_length = 95.0; // [60.0, 160.0] Preform length (mm)
let body_diameter = 24.4; // [20.0, 30.0] Body outer diameter (mm)
let wall = 3.2; // [2.0, 4.5] Body wall thickness (mm)
let support_ring_diameter = 33.0; // [30.0, 36.0] Support ring diameter (mm)
const thread_t = 27.43;
const thread_e = 25.07;
const bore = 21.74;
const pitch = 2.7;
let rt = thread_t / 2.0;
let re = thread_e / 2.0;
let rb = bore / 2.0;
let ro = body_diameter / 2.0;
let ri = ro - wall;
let rs = support_ring_diameter / 2.0;
let top = total_length;
const k = 0.7071;
let profile = sketch("XZ")
    .move_to(0, 0)
    .arc_to(ro * k, ro - ro * k, ro, ro)
    .vline_to(top - 22.0)
    .line_to(re, top - 19.5)
    .vline_to(top - 17.0)
    .hline_to(rs)
    .vline_to(top - 15.4)
    .hline_to(re)
    .vline_to(top - 13.6)
    .line_to(re + 1.9, top - 13.0)
    .vline_to(top - 12.4)
    .line_to(re, top - 11.8)
    .vline_to(top - 0.5)
    .line_to(re - 0.5, top)
    .hline_to(rb)
    .vline_to(top - 19.0)
    .line_to(ri, top - 25.0)
    .vline_to(ro)
    .arc_to(ri * k, ro - ri * k, 0, ro - ri)
    .close();
let preform = profile.to_face().revolve("Z", 360);
// thread ridge, 1.5 turns, root sunk 0.3 mm into the neck
let section = polygon([[re - 0.3, 0, -0.8], [rt, 0, -0.35], [rt, 0, 0.35], [re - 0.3, 0, 0.8]]);
let sections = [];
for i in 0..=18 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, top - 10.0 + t * pitch]));
}
preform + loft(sections, true)
