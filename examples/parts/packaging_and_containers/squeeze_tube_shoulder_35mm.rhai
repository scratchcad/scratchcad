// Squeeze tube head for a 35 mm tube: 1.2 mm thick conical shoulder with a 5 mm weld skirt, 13 mm neck with a 2.5 mm pitch external thread (2 turns) and a 5 mm orifice
let tube_diameter = 35.0; // [19.0, 50.0] Tube diameter (mm)
let shoulder_height = 9.0; // [5.0, 15.0] Shoulder height (mm)
let neck_diameter = 13.0; // [8.0, 18.0] Neck root diameter (mm)
let neck_height = 9.0; // [6.0, 14.0] Neck height (mm)
let orifice = 5.0; // [2.0, 8.0] Orifice diameter (mm)
let wall = 1.2; // [0.8, 2.0] Shoulder wall (mm)
const pitch = 2.5;
let rt = tube_diameter / 2.0;
let rn = neck_diameter / 2.0;
let rh = min(orifice / 2.0, rn - 1.2);
let zn = shoulder_height;
let ztop = zn + neck_height;
let profile = sketch("XZ")
    .move_to(rt - 0.5, -5.0)
    .hline_to(rt)
    .vline_to(0)
    .line_to(rn, zn)
    .vline_to(ztop - 0.5)
    .line_to(rn - 0.5, ztop)
    .hline_to(rh)
    .vline_to(zn - wall)
    .line_to(rt - wall * 1.6, -0.3)
    .hline_to(rt - 0.5)
    .close();
let head = profile.to_face().revolve("Z", 360);
let section = polygon([[rn - 0.3, 0, -0.7], [rn + 0.9, 0, -0.25], [rn + 0.9, 0, 0.25], [rn - 0.3, 0, 0.7]]);
let sections = [];
for i in 0..=24 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, zn + 1.5 + t * pitch]));
}
head + loft(sections, true)
