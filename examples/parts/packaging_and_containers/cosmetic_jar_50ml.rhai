// Heavy-wall cosmetic cream jar, 50 ml: 60 mm body 36 mm tall with an 8 mm thick base, 48 mm cavity 28 mm deep below the neck, 53 mm neck 8 mm tall with a 3 mm pitch external thread (2 turns) for a 62 mm lid
let body_diameter = 60.0; // [45.0, 80.0] Body diameter (mm)
let body_height = 36.0; // [25.0, 50.0] Body height (mm)
let cavity_diameter = 48.0; // [35.0, 70.0] Cavity diameter (mm)
let base_thickness = 8.0; // [3.0, 15.0] Base thickness (mm)
let neck_height = 8.0; // [5.0, 12.0] Neck height (mm)
const pitch = 3.0;
let ro = body_diameter / 2.0;
let rc = min(cavity_diameter / 2.0, ro - 4.0);
let rn = rc + 2.5;
let h = body_height;
let jar = cylinder(ro, h).fillet(3.0, "<Z").fillet(1.5, ">Z") + cylinder([0, 0, h - 0.1], "Z", rn, neck_height + 0.1).chamfer(0.5, ">Z");
jar = jar - cylinder([0, 0, base_thickness], "Z", rc, h + neck_height).fillet(4.0, "<Z");
let section = polygon([[rn - 0.3, 0, -0.9], [rn + 1.2, 0, -0.35], [rn + 1.2, 0, 0.35], [rn - 0.3, 0, 0.9]]);
let sections = [];
for i in 0..=24 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, h + 1.5 + t * pitch * min(1.0, (neck_height - 3.0) / (2.0 * pitch))]));
}
let print_volume = PI() * rc * rc * (h - base_thickness) / 1000.0;
print(`capacity to the neck: ${print_volume} ml`);
jar + loft(sections, true)
