// DIN 934 M8 hex nut
let diameter = 8.0; // [3.0, 20.0] Thread diameter (mm)
let thread_pitch = 1.25; // [0.5, 2.5] Thread pitch (mm)
let across_flats = 13.0; // [5.5, 30.0] Width across flats (mm)
let height = 6.5; // [2.0, 16.0] Height (mm)
let tan30 = (30.0 * PI() / 180.0).tan();
let r_corner = across_flats / sqrt(3.0);
let r_major = diameter / 2.0;
let r_bore = r_major - 0.5413 * thread_pitch;
let pts = [];
for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([r_corner * a.cos(), r_corner * a.sin()]); }
let hex = polygon(pts).to_face().extrude(height);
let r0 = across_flats * 0.475;
let drop = (r_corner + 1.0 - r0) * tan30;
let env = sketch("XZ").move_to(0, 0).hline_to(r0).line_to(r_corner + 1.0, drop).vline_to(height - drop)
    .line_to(r0, height).hline_to(0).close().to_face().revolve("Z", 360);
let body = hex & env;
fn helical(section, pitch, turns) {
    let sections = [];
    for i in 0..=(turns * 12) {
        let t = i.to_float() / 12.0;
        sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    loft(sections, true)
}
let w = thread_pitch / 16.0 + (r_major + 0.1 - (r_bore - 0.05)) * tan30;
let section = polygon([[r_bore - 1.0, 0, -w], [r_bore - 0.05, 0, -w], [r_major + 0.1, 0, -thread_pitch / 16.0],
                       [r_major + 0.1, 0, thread_pitch / 16.0], [r_bore - 0.05, 0, w], [r_bore - 1.0, 0, w]]);
let turns = (height / thread_pitch).ceiling().to_int() + 2;
let groove = helical(section, thread_pitch, turns).translate([0, 0, -thread_pitch]);
let bore = cylinder([0, 0, -3.0 * thread_pitch], "Z", r_bore, (turns + 4).to_float() * thread_pitch);
let sink = cone(r_major + 0.4, 0, r_major + 0.4);
body - fuse_all([bore + groove, sink.translate([0, 0, -0.4]), sink.mirror("XY").translate([0, 0, height + 0.4])])
