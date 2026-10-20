// Dropper cap for an 18-415 bottle neck: 20.4 mm diameter, 14 mm skirt with internal 8 TPI (3.175 mm) thread, 30 grip ribs, 11.2 mm bulb collar with retaining bead, 7.2 mm pipette hole
let cap_diameter = 20.4; // [19.5, 24.0] Cap diameter (mm)
let skirt_height = 14.0; // [10.0, 18.0] Skirt height (mm)
let collar_height = 6.5; // [4.0, 10.0] Bulb collar height (mm)
let collar_diameter = 11.2; // [9.0, 14.0] Bulb collar diameter (mm)
let pipette_hole = 7.2; // [5.0, 8.5] Pipette hole diameter (mm)
const pitch = 3.175;
const r_root = 9.2;
const r_crest = 8.4;
let ro = max(cap_diameter / 2.0, r_root + 0.8);
let rc = max(collar_diameter / 2.0, pipette_hole / 2.0 + 0.8);
let top = skirt_height + 1.5;
let cap = cylinder(ro, top).fillet(0.6, ">Z") - cylinder([0, 0, -1], "Z", r_root, skirt_height + 1.0);
cap = cap + cylinder([0, 0, top - 0.1], "Z", rc, collar_height + 0.1) + cylinder([0, 0, top + collar_height - 1.0], "Z", rc + 0.4, 1.0).chamfer(0.3, ">Z");
cap = cap - cylinder([0, 0, -1], "Z", pipette_hole / 2.0, top + collar_height + 2.0);
let section = polygon([[r_root + 0.3, 0, -0.9], [r_crest, 0, -0.35], [r_crest, 0, 0.35], [r_root + 0.3, 0, 0.9]]);
let sections = [];
for i in 0..=15 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(-t * 360.0).translate([0, 0, skirt_height - 2.0 - t * pitch]));
}
cap = cap + loft(sections, true);
let ribs = [];
for i in 0..30 {
    ribs.push(cylinder([ro + 0.05, 0, 0.8], "Z", 0.3, skirt_height - 1.6).rotate_z(i.to_float() * 12.0));
}
cap - compound(ribs)
