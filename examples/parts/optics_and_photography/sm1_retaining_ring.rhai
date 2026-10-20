// Thorlabs SM1RR retaining ring: 1.035"-40 (SM1) external thread, 2.5 mm thick, 22.9 mm clear bore, two 1.5 mm spanner slots
let thickness = 2.5; // [1.5, 5.0] Ring thickness (mm)
let bore = 22.9; // [18.0, 24.0] Clear aperture (mm)
let slot_width = 1.5; // [0.8, 2.5] Spanner slot width (mm)
let slot_depth = 1.0; // [0.5, 1.4] Spanner slot depth (mm)
const pitch = 0.635;
const r_major = 13.1445;
let r_minor = r_major - 0.6134 * pitch;
fn thread_ridge(r_root, r_crest, pitch, length) {
    let hc = pitch / 16.0;
    let hr = min(hc + (r_crest - r_root).abs() * 0.57735, 0.42 * pitch);
    let deep = if r_crest > r_root { r_root - 0.3 } else { r_root + 0.3 };
    let section = polygon([[deep, 0, -hr], [r_root, 0, -hr], [r_crest, 0, -hc], [r_crest, 0, hc], [r_root, 0, hr], [deep, 0, hr]]);
    let turns = (length / pitch).ceiling().to_int() + 2;
    let sections = [];
    for i in 0..=(turns * 12) {
        let t = i.to_float() / 12.0;
        sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    loft(sections, true).translate([0, 0, -pitch])
}
// core at the minor diameter, longer than the ring, with the ridge fused on, trimmed to thickness
let core = cylinder([0, 0, -1.0], "Z", r_minor, thickness + 2.0);
let ring = (core + thread_ridge(r_minor - 0.05, r_major, pitch, thickness)) & cylinder([0, 0, 0], "Z", r_major + 1.0, thickness);
ring -= cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 2.0);
for a in [0.0, 180.0] {
    ring -= box_from_corners([bore / 2.0 - 1.0, -slot_width / 2.0, thickness - slot_depth], [r_major + 1.0, slot_width / 2.0, thickness + 1.0]).rotate_z(a);
}
ring
