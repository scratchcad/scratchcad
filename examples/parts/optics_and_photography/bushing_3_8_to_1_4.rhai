// Brass tripod reducer bushing: 3/8-16 UNC outside, 1/4-20 UNC inside (shown as its 5.1 mm tap-drill bore), 9.5 mm long, 1.2 mm screwdriver slot across the top
let length = 9.5; // [5.0, 15.0] Bushing length (mm)
let slot_width = 1.2; // [0.8, 2.0] Slot width (mm)
let slot_depth = 1.5; // [0.8, 3.0] Slot depth (mm)
const pitch = 1.5875;
const r_major = 4.7625;
const inner_bore = 5.1;
let r_minor = r_major - 0.6134 * pitch;
// core plus a lofted helical ridge; the core runs past both ends of the ridge, then all is trimmed
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
// envelope with 45 deg lead-in chamfers at both ends of the outer thread
let c = r_major + 1.1 - r_minor;
let envelope = sketch("XZ").move_to(0, 0).hline_to(r_minor - 0.1).line_to(r_major + 1.0, c).vline_to(length - c).line_to(r_minor - 0.1, length).hline_to(0).close().to_face().revolve("Z", 360);
let bushing = threaded_rod(r_minor, r_major, pitch, length) & envelope;
bushing = bushing - cylinder([0, 0, -1.0], "Z", inner_bore / 2.0, length + 2.0);
bushing - box_centered(2.0 * r_major + 2.0, slot_width, 2.0 * slot_depth).translate([0, 0, length])
