// Cable housing end reamer: 12 mm plain round handle 40 mm long, 6 mm cone tapering to 2 mm over 10 mm with three 0.8 mm flute slots to open crushed housing liners, 1 mm handle chamfers
let handle_d = 12.0; // [10.0, 20.0] Handle diameter (mm)
let handle_len = 40.0; // [25.0, 70.0] Handle length (mm)
let cone_base = 6.0; // [5.0, 8.0] Cone base diameter (mm)
let cone_len = 10.0; // [6.0, 15.0] Cone length (mm)
const tip_d = 2.0;
const flutes = 3;
let handle = cylinder(handle_d / 2.0, handle_len);
let handle = handle.chamfer(1.0, handle.edges(">Z or <Z"));
let tip = cone(cone_base / 2.0, tip_d / 2.0, cone_len).translate([0, 0, handle_len - 0.5]);
let cuts = [];
for i in 0..flutes {
    cuts.push(box_from_corners([0.4, -0.4, handle_len + 1.0], [cone_base, 0.4, handle_len + cone_len + 1.0]).rotate_z(i.to_float() * 120.0));
}
(handle + tip) - fuse_all(cuts)
