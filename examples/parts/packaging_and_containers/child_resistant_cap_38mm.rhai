// Push-and-turn child-resistant cap for a 38-400 neck: 44.2 mm outer shell 20 mm tall with 12 drive teeth under its top and a retaining bead, free-spinning inner cap with 12 matching teeth and an internal 6 TPI (4.23 mm) thread
let outer_diameter = 44.2; // [42.0, 50.0] Outer shell diameter (mm)
let height = 20.0; // [16.0, 26.0] Cap height (mm)
let wall = 1.3; // [1.0, 2.0] Wall thickness (mm)
let teeth = 12; // [6, 18] Number of drive teeth
const pitch = 4.233;
const r_bore = 19.1;
const r_crest = 18.2;
let ri_out = r_bore + wall;
let ro_in = ri_out + 0.4;
let ro = max(outer_diameter / 2.0, ro_in + wall);
let top_in = height - 1.5;
// outer shell with a bead under the inner cap's rim
let outer = cylinder(ro, height).fillet(1.0, ">Z") - cylinder([0, 0, -1], "Z", ro_in, top_in + 1.0);
outer = outer + (cylinder([0, 0, 0], "Z", ro_in + 0.1, 1.0) - cylinder([0, 0, -1], "Z", ri_out - 0.4, 3.0));
let drive = [];
for i in 0..teeth {
    drive.push(box_from_corners([12.0, -1.0, top_in - 0.8], [ro_in + 0.05, 1.0, top_in + 0.1]).rotate_z(i.to_float() * 360.0 / teeth.to_float()));
}
outer = fuse_all([outer] + drive);
// inner cap: sits between the bead and the drive teeth, teeth offset half a pitch
const z0 = 1.2;
let z1 = top_in - 1.0;
let inner = cylinder([0, 0, z0], "Z", ri_out, z1 - z0) - cylinder([0, 0, z0 - 1.0], "Z", r_bore, z1 - z0 - 0.5);
let driven = [];
for i in 0..teeth {
    driven.push(box_from_corners([12.0, -1.0, z1 - 0.1], [ri_out - 0.3, 1.0, z1 + 0.8]).rotate_z((i.to_float() + 0.5) * 360.0 / teeth.to_float()));
}
let section = polygon([[r_bore + 0.3, 0, -1.0], [r_crest, 0, -0.4], [r_crest, 0, 0.4], [r_bore + 0.3, 0, 1.0]]);
let sections = [];
for i in 0..=12 {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(-t * 360.0).translate([0, 0, z1 - 4.0 - t * pitch]));
}
inner = fuse_all([inner, loft(sections, true)] + driven);
[outer, inner]
