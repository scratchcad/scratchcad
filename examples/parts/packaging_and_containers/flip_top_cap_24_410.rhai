// Flip-top dispensing cap for a 24-410 neck, as moulded open: 26 mm base 13 mm tall with an internal 8 TPI thread and a 3 mm orifice spout, lid hinged at the back on a 0.6 mm living hinge with a plug that seals the spout
let cap_diameter = 26.0; // [25.0, 32.0] Cap diameter (mm)
let base_height = 13.0; // [10.0, 18.0] Base height (mm)
let lid_height = 4.3; // [3.0, 7.0] Lid height (mm)
let orifice = 3.0; // [1.5, 5.0] Orifice diameter (mm)
const pitch = 3.175;
const r_root = 12.3;
const r_crest = 11.4;
let r = max(cap_diameter / 2.0, r_root + 0.8);
let deck = base_height - 1.5;
let ro = orifice / 2.0;
let spout_top = base_height + min(3.0, lid_height - 1.0);
let base = cylinder(r, base_height) - cylinder([0, 0, -1], "Z", r_root, deck + 1.0);
base = base + cylinder([0, 0, base_height - 0.1], "Z", ro + 0.7, spout_top - base_height + 0.1);
base = base - cylinder([0, 0, deck - 1.0], "Z", ro, spout_top - deck + 2.0);
let section = polygon([[r_root + 0.3, 0, -0.9], [r_crest, 0, -0.35], [r_crest, 0, 0.35], [r_root + 0.3, 0, 0.9]]);
let sections = [];
for i in 0..=15 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(-t * 360.0).translate([0, 0, deck - 2.0 - t * pitch]));
}
base = base + loft(sections, true);
// lid as it would sit closed, then flipped 180 degrees about the hinge line at the back
let z0 = base_height + 0.2;
let lid = cylinder([0, 0, z0], "Z", r, lid_height) - cylinder([0, 0, z0 - 1.0], "Z", r - 0.8, lid_height);
lid = lid.fillet(0.8, ">Z");
lid = lid + cylinder([0, 0, spout_top - 1.8], "Z", ro - 0.05, z0 + lid_height - spout_top + 1.0);
lid = lid + box_from_corners([-5.0, r - 0.5, z0 + lid_height - 2.5], [5.0, r + 1.5, z0 + lid_height - 1.5]);
lid = lid.rotate([0, -r, base_height + 0.1], "X", 180.0);
let hinge = box_from_corners([-4.0, -r - 0.9, base_height - 0.5], [4.0, -r + 0.6, base_height + 0.1]);
fuse_all([base, lid, hinge])
