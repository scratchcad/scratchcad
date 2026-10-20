// Projector ceiling mount plate: 160 mm round plate 5 mm thick, four 6 mm ceiling slots on a 120 mm circle, 38 mm (1.5 in NPT) pole socket boss 30 mm tall with a 48 mm OD and 6 mm grub screw hole
let diameter = 160.0; // [120.0, 220.0] Plate diameter (mm)
let thickness = 5.0; // [4.0, 8.0] Plate thickness (mm)
let pole = 38.0; // [26.0, 50.0] Pole socket diameter (mm)
let boss_height = 30.0; // [20.0, 50.0] Socket boss height (mm)
let plate = cylinder(diameter / 2.0, thickness);
let p = plate.chamfer(1.0, plate.edges(">Z"));
let boss = cylinder([0, 0, thickness - 0.01], "Z", pole / 2.0 + 5.0, boss_height);
let slots = [];
for k in 0..4 {
    let s = box_centered(14.0, 6.0, thickness + 2.0).translate([60.0, 0, thickness / 2.0]);
    slots.push(s.fillet(2.9, s.edges("|Z")).rotate_z(45.0 + k.to_float() * 90.0));
}
let ribs = [];
for k in 0..4 { ribs.push(polygon("XZ", [[pole / 2.0 + 4.0, thickness - 0.01], [pole / 2.0 + 25.0, thickness - 0.01], [pole / 2.0 + 4.0, thickness + boss_height * 0.7]]).to_face().extrude([0, 4.0, 0]).translate([0, -2.0, 0]).rotate_z(k.to_float() * 90.0)); }
(p + boss + fuse_all(ribs)) - fuse_all(slots) - cylinder([0, 0, 3.0], "Z", pole / 2.0, boss_height + 5.0) - cylinder([0, -diameter / 2.0, thickness + boss_height * 0.6], "Y", 3.0, diameter / 2.0).rotate_z(45.0)
