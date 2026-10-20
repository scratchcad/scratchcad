// Screw-down watch case back, 36 mm: 1.5 mm flange, 31 mm threaded spigot 2 mm tall with an M31 x 0.5 thread, hollowed to a 0.8 mm floor, six case-opener notches in the flange rim
let flange_diameter = 36.0; // [28.0, 46.0] Flange diameter (mm)
let flange_thickness = 1.5; // [1.0, 2.5] Flange thickness (mm)
let thread_diameter = 31.0; // [24.0, 42.0] Thread major diameter (mm)
let spigot_height = 2.0; // [1.2, 3.0] Threaded spigot height (mm)
let floor = 0.8; // [0.5, 1.5] Floor thickness (mm)
let notches = 6; // [3, 12] Opener notches
const pitch = 0.5;
const depth = 0.27;
let rd = min(thread_diameter, flange_diameter - 2.0) / 2.0;
let r_root = rd - depth;
let flange = cylinder(flange_diameter / 2.0, flange_thickness).chamfer(0.4, "%CIRCLE and <Z");
// thread ridge lofted along the helix, root sunk 0.1 mm into the spigot, trimmed to the spigot height after fusing
let section = polygon([[r_root - 0.1, 0, -0.2], [rd, 0, -0.05], [rd, 0, 0.05], [r_root - 0.1, 0, 0.2]]);
let turns = (spigot_height / pitch).ceiling().to_int() + 2;
let sections = [];
for i in 0..=(turns * 12) {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
}
let ridge = loft(sections, true).translate([0, 0, flange_thickness - pitch]);
// the spigot runs past both ends of the ridge (a ridge end crossing its end face makes the fuse fail)
let spigot = cylinder([0, 0, flange_thickness - 1.0], "Z", r_root, turns.to_float() * pitch + 2.0);
let threaded = (spigot + ridge) & cylinder([0, 0, flange_thickness - 0.5], "Z", rd + 1.0, spigot_height + 0.5 - 0.15);
let back = flange + threaded;
back = back - cylinder([0, 0, floor], "Z", r_root - 1.2, flange_thickness + spigot_height);
let cuts = [];
for i in 0..notches {
    cuts.push(box_centered(2.0, 3.0, 1.2).translate([0, flange_diameter / 2.0, flange_thickness * 0.5]).rotate_z(i.to_float() * 360.0 / notches.to_float()));
}
back - compound(cuts)
