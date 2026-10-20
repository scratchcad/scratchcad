// Screw cap for a 28 mm PCO 1881 neck: 30.6 mm diameter, 14 mm tall skirt, 1.2 mm top with a bore-seal plug ring, internal 2.7 mm pitch thread (25.9 mm crest), 60 grip flutes and a 3.5 mm tamper band on eight bridges
let cap_diameter = 30.6; // [29.0, 34.0] Cap diameter (mm)
let skirt_height = 14.0; // [10.0, 18.0] Skirt height (mm)
let top_thickness = 1.2; // [0.8, 2.0] Top thickness (mm)
let flutes = 60; // [0, 90] Number of grip flutes
let band_height = 3.5; // [0.0, 5.0] Tamper band height (mm)
const pitch = 2.7;
const r_root = 14.0;
const r_crest = 12.95;
let ro = max(cap_diameter / 2.0, r_root + 0.8);
let h = skirt_height + top_thickness;
let cap = cylinder(ro, h).fillet(0.6, ">Z") - cylinder([0, 0, -1], "Z", r_root, skirt_height + 1.0);
// bore seal: plug ring that drops into the 21.7 mm bore
cap = cap + (cylinder([0, 0, skirt_height - 2.5], "Z", 10.75, 2.6) - cylinder([0, 0, skirt_height - 3.0], "Z", 9.9, 4.0));
// internal thread, 1.5 turns, root sunk 0.3 mm into the skirt
let section = polygon([[r_root + 0.3, 0, -0.8], [r_crest, 0, -0.35], [r_crest, 0, 0.35], [r_root + 0.3, 0, 0.8]]);
let sections = [];
for i in 0..=18 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(-t * 360.0).translate([0, 0, skirt_height - 2.5 - 4.0 - t * pitch]));
}
cap = cap + loft(sections, true);
let cuts = [];
for i in 0..flutes {
    cuts.push(cylinder([ro + 0.1, 0, 0.6], "Z", 0.35, h - 1.6).rotate_z(i.to_float() * 360.0 / flutes.to_float()));
}
if flutes > 0 { cap = cap - compound(cuts); }
// tamper band below a 0.5 mm gap, held by eight small bridges, with an inward hook bead
if band_height > 0.0 {
    let band = cylinder([0, 0, -band_height - 0.5], "Z", ro - 0.4, band_height) - cylinder([0, 0, -band_height - 1.5], "Z", r_root - 0.1, band_height + 2.0);
    band = band + (cylinder([0, 0, -band_height - 0.5], "Z", r_root, 1.2) - cylinder([0, 0, -band_height - 1.5], "Z", r_root - 0.8, 3.0));
    let bridges = [];
    for i in 0..8 {
        bridges.push(box_centered(0.6, 0.6, 0.9).translate([r_root + 0.5, 0, -0.25]).rotate_z(i.to_float() * 45.0 + 22.5));
    }
    cap = fuse_all([cap, band] + bridges);
}
cap.translate([0, 0, band_height + 0.5])
