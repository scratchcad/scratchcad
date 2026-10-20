// Pharmacy pill bottle (vial) for a 38-400 cap: 44 mm body 80 mm tall, 1.4 mm wall, 2 mm base, neck with 37.6 mm thread (T) on a 35.9 mm root (E), 6 TPI (4.23 mm) single-start thread, 1 turn
let body_diameter = 44.0; // [40.0, 55.0] Body diameter (mm)
let height = 80.0; // [40.0, 120.0] Overall height (mm)
let wall = 1.4; // [1.0, 2.5] Wall thickness (mm)
let neck_height = 12.0; // [9.0, 15.0] Neck height (mm)
const pitch = 4.233;
const r_t = 18.8;
const r_e = 17.95;
let ro = max(body_diameter / 2.0, r_e + 2.0);
let zs = height - neck_height;
let profile = sketch("XZ")
    .move_to(0, 0)
    .hline_to(ro - 2.0)
    .arc_to(ro - 0.586, 0.586, ro, 2.0)
    .vline_to(zs - 3.0)
    .line_to(r_e, zs)
    .vline_to(height - 0.5)
    .line_to(r_e - 0.5, height)
    .hline_to(r_e - wall)
    .vline_to(zs)
    .line_to(ro - wall, zs - 3.0 - wall * 0.5)
    .vline_to(2.0 + 1.0)
    .arc_to(ro - wall - 0.3, 2.3, ro - wall - 1.0, 2.0)
    .hline_to(0)
    .close();
let bottle = profile.to_face().revolve("Z", 360);
let section = polygon([[r_e - 0.3, 0, -1.0], [r_t, 0, -0.4], [r_t, 0, 0.4], [r_e - 0.3, 0, 1.0]]);
let sections = [];
for i in 0..=12 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, zs + 2.5 + t * pitch]));
}
bottle + loft(sections, true)
