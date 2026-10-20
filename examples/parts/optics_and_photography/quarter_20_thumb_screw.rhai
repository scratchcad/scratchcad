// 1/4-20 UNC camera thumb screw: 9.5 mm (3/8 in) thread, 19 mm knurled head 7 mm tall over a 1.5 mm neck, chamfered tip
let thread_length = 9.5; // [5.0, 25.0] Thread length (mm)
let head_diameter = 19.0; // [12.0, 30.0] Head diameter (mm)
let head_height = 7.0; // [4.0, 12.0] Head height (mm)
let neck_length = 1.5; // [0.5, 4.0] Plain neck under the head (mm)
let knurl_count = 30; // [0, 60] Knurl grooves on the head
const pitch = 1.27;
const r_major = 3.175;
let r_minor = r_major - 0.6134 * pitch;
// core plus a lofted helical ridge; the core runs past both ends of the ridge (a ridge end crossing
// the core's end face makes the fuse fail), and the result is trimmed afterwards
fn threaded_rod(r_minor, r_major, pitch, length) {
    let hc = pitch / 16.0;
    let r_root = r_minor - 0.05;
    let hr = min(hc + (r_major - r_root) * 0.57735, 0.42 * pitch);
    let section = polygon([[r_root - 0.3, 0, -hr], [r_root, 0, -hr], [r_major, 0, -hc], [r_major, 0, hc], [r_root, 0, hr], [r_root - 0.3, 0, hr]]);
    let turns = (length / pitch).ceiling().to_int() + 2;
    let sections = [];
    for i in 0..=(turns * 12) {
        let t = i.to_float() / 12.0;
        sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    let ridge = loft(sections, true).translate([0, 0, -pitch]);
    cylinder([0, 0, -pitch - 1.0], "Z", r_minor, (turns + 1).to_float() * pitch + 2.0) + ridge
}
// thread trimmed by a revolved envelope with a 45 deg tip chamfer, then turned to point down
let envelope = sketch("XZ").move_to(0, -0.3).hline_to(r_major + 1.0).vline_to(thread_length - (r_major + 1.0 - r_minor + 0.2))
    .line_to(r_minor - 0.2, thread_length).hline_to(0).close().to_face().revolve("Z", 360);
let threads = (threaded_rod(r_minor, r_major, pitch, thread_length) & envelope).rotate_x(180.0);
// neck and knurled head above
let neck = cylinder([0, 0, -0.1], "Z", r_major - 0.25, neck_length + 0.3);
let head = cylinder([0, 0, neck_length], "Z", head_diameter / 2.0, head_height).fillet(1.0, "%CIRCLE");
let knurls = [];
for i in 0..knurl_count {
    knurls.push(cylinder([head_diameter / 2.0 + 0.2, 0, neck_length - 1.0], "Z", 0.8, head_height + 2.0).rotate_z(i.to_float() * 360.0 / knurl_count.to_float()));
}
if knurl_count > 0 { head = head - compound(knurls); }
fuse_all([threads, neck, head])
