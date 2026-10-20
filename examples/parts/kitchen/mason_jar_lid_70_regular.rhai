// One-piece storage lid for a regular-mouth (70-450) mason jar: 76 mm OD, 13 mm skirt, 2.5 mm top, internal thread 6 TPI (4.23 mm pitch) from 71 to 68 mm, 60 grip ribs
let skirt_height = 13.0; // [9.0, 18.0] Skirt height (mm)
let top_thickness = 2.5; // [1.5, 4.0] Top thickness (mm)
let thread_major = 71.0; // [70.0, 72.0] Thread root diameter in the lid (mm)
let thread_depth = 1.5; // [1.0, 2.0] Thread depth (mm)
let wall = 2.5; // [1.5, 4.0] Skirt wall outside the thread root (mm)
let rib_count = 60; // [0, 120] Grip ribs
const pitch = 4.233;
let r_root = thread_major / 2.0;
let r_crest = r_root - thread_depth;
let ro = r_root + wall;
// internal thread ridge, root sunk 0.3 mm into a skirt that runs past both ends of it (a ridge end
// crossing the skirt's end face makes the fuse fail); the lid is trimmed to height afterwards
let hc = pitch / 10.0;
let hr = min(hc + thread_depth * 0.57735, 0.42 * pitch);
let section = polygon([[r_root + 0.3, 0, -hr], [r_root, 0, -hr], [r_crest, 0, -hc], [r_crest, 0, hc], [r_root, 0, hr], [r_root + 0.3, 0, hr]]);
let turns = (skirt_height / pitch).ceiling().to_int() + 2;
let sections = [];
for i in 0..=(turns * 12) {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
}
let ridge = loft(sections, true).translate([0, 0, -pitch]);
let z_end = (turns + 1).to_float() * pitch;
let skirt = cylinder([0, 0, -pitch - 2.0], "Z", ro, z_end + 4.0) - cylinder([0, 0, -pitch - 3.0], "Z", r_root, z_end + 6.0);
let lid = (skirt + ridge) & cylinder([0, 0, 0], "Z", ro + 1.0, skirt_height);
lid = lid + cylinder([0, 0, skirt_height - 0.5], "Z", ro, top_thickness + 0.5).fillet(1.0, "%CIRCLE and >Z");
// grip ribs on the skirt
let ribs = [];
for i in 0..rib_count {
    ribs.push(cylinder([ro + 0.2, 0, -1.0], "Z", 0.6, skirt_height + 1.0).rotate_z(i.to_float() * 360.0 / rib_count.to_float()));
}
if rib_count > 0 { lid = lid - compound(ribs); }
lid.rotate_x(180.0).translate([0, 0, skirt_height + top_thickness])
