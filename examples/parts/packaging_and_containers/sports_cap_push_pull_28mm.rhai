// Push-pull sports bottle cap for a 28 mm PCO neck: 31 mm ribbed base with an internal 2.7 mm pitch thread, 9 mm spout stem whose 4 mm sealing pin sits on three spokes, and the separate pull slide shown open 4 mm up
let cap_diameter = 31.0; // [29.0, 36.0] Cap diameter (mm)
let skirt_height = 13.0; // [10.0, 18.0] Skirt height (mm)
let stem_height = 12.0; // [8.0, 18.0] Spout stem height (mm)
let slide_lift = 4.0; // [0.0, 6.0] Slide opening lift (mm)
const pitch = 2.7;
const r_root = 14.0;
const r_crest = 12.95;
let ro = max(cap_diameter / 2.0, r_root + 1.0);
let deck = skirt_height + 1.5;
let base = cylinder(ro, deck).fillet(1.0, ">Z") - cylinder([0, 0, -1], "Z", r_root, skirt_height + 1.0);
let section = polygon([[r_root + 0.3, 0, -0.8], [r_crest, 0, -0.35], [r_crest, 0, 0.35], [r_root + 0.3, 0, 0.8]]);
let sections = [];
for i in 0..=18 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(-t * 360.0).translate([0, 0, skirt_height - 2.0 - t * pitch]));
}
base = base + loft(sections, true);
// stem tube with a central sealing pin held by three spokes at its top
let zt = deck + stem_height;
let stem = cylinder([0, 0, deck - 0.1], "Z", 4.5, stem_height + 0.1) - cylinder([0, 0, deck - 2.0], "Z", 3.5, stem_height + 3.0);
let pin = cylinder([0, 0, zt - 3.0], "Z", 2.0, 3.0 + 3.0).fillet(0.5, ">Z");
let spokes = [];
for i in 0..3 {
    spokes.push(box_from_corners([0, -0.5, zt - 3.0], [3.8, 0.5, zt - 1.0]).rotate_z(i.to_float() * 120.0));
}
base = fuse_all([base, stem, pin] + spokes);
let ribs = [];
for i in 0..36 {
    ribs.push(cylinder([ro + 0.05, 0, 0.6], "Z", 0.35, skirt_height - 1.0).rotate_z(i.to_float() * 10.0));
}
base = base - compound(ribs);
// slide: sleeve over the stem, top with an orifice that the pin plugs when pushed down
let zs = deck + 2.0 + slide_lift;
let slide = cylinder([0, 0, zs], "Z", 6.5, stem_height + 2.0) - cylinder([0, 0, zs - 1.0], "Z", 4.6, stem_height + 1.0 + 0.0);
slide = slide.fillet(0.8, ">Z") - cylinder([0, 0, zs], "Z", 2.05, stem_height + 4.0);
[base, slide]
