// Lotion pump closure collar for a 28-410 neck: 30.5 mm ribbed collar 10 mm tall, internal 6 TPI (4.23 mm) thread on a 27.7 mm crest, 1.4 mm top with a 15 mm turret for the pump body and a 12 mm bore
let collar_diameter = 30.5; // [29.5, 34.0] Collar diameter (mm)
let skirt_height = 10.0; // [8.0, 14.0] Skirt height (mm)
let turret_height = 4.0; // [0.0, 8.0] Turret height (mm)
let pump_bore = 12.0; // [8.0, 16.0] Pump body bore (mm)
let ribs = 40; // [0, 72] Number of grip ribs
const pitch = 4.233;
const r_root = 14.4;
const r_crest = 13.5;
let ro = max(collar_diameter / 2.0, r_root + 0.8);
let top = skirt_height + 1.4;
let rb = min(pump_bore / 2.0, r_root - 2.0);
let collar = cylinder(ro, top).fillet(0.5, ">Z") - cylinder([0, 0, -1], "Z", r_root, skirt_height + 1.0);
if turret_height > 0.0 {
    collar = collar + cylinder([0, 0, top - 0.1], "Z", rb + 1.5, turret_height + 0.1).chamfer(0.4, ">Z");
}
collar = collar - cylinder([0, 0, -1], "Z", rb, top + turret_height + 2.0);
let section = polygon([[r_root + 0.3, 0, -1.0], [r_crest, 0, -0.4], [r_crest, 0, 0.4], [r_root + 0.3, 0, 1.0]]);
let sections = [];
for i in 0..=14 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(-t * 360.0).translate([0, 0, skirt_height - 2.0 - t * pitch]));
}
collar = collar + loft(sections, true);
let cuts = [];
for i in 0..ribs {
    cuts.push(cylinder([ro + 0.05, 0, 0.6], "Z", 0.3, skirt_height - 0.6).rotate_z(i.to_float() * 360.0 / ribs.to_float()));
}
if ribs > 0 { collar = collar - compound(cuts); }
collar
