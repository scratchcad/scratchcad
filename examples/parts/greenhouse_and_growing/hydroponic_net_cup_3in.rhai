// Hydroponic net cup: 3 in net pot, 76 mm rim lip 4 mm wide, 72 mm top tapering to 55 mm base, 70 mm tall, 1.5 mm wall, 12 vertical slots 4 mm wide and a slotted base
// # Cup
let top_d = 72.0; // [50.0, 100.0] Top diameter (mm)
let base_d = 55.0; // [35.0, 80.0] Base diameter (mm)
let height = 70.0; // [45.0, 100.0] Cup height (mm)
let wall = 1.5; // [1.2, 2.5] Wall thickness (mm)
// # Slots
let slots = 12; // [6, 20] Number of side slots
let slot_w = 4.0; // [2.0, 6.0] Slot width (mm)
let rt = top_d / 2.0;
let rb = base_d / 2.0;
let shell = cone(rb, rt, height) - cone(rb - wall, rt - wall, height).translate([0, 0, wall]);
let lip = cylinder([0, 0, height - 3.0], "Z", rt + 4.0, 3.0) - cylinder([0, 0, height - 4.0], "Z", rt - wall, 5.0);
let cuts = [];
for i in 0..slots {
    cuts.push(box_from_corners([0, -slot_w / 2.0, 8.0], [rt + 5.0, slot_w / 2.0, height - 10.0]).rotate_z(i.to_float() * 360.0 / slots.to_float()));
}
let base_slots = [box_centered(base_d * 0.6, slot_w, wall * 4.0), box_centered(slot_w, base_d * 0.6, wall * 4.0)];
let hub = cylinder([0, 0, -1.0], "Z", 5.0, wall * 3.0);
(shell + lip) - fuse_all(cuts) - (fuse_all(base_slots) - hub)
