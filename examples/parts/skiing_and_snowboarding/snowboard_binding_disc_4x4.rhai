// Snowboard binding disc for 4x4 inserts: 100 mm disc 5 mm thick with a 3 mm wide, 2 mm deep rim step, four 6.5 mm M6 slots 16 mm long on the 40 x 40 mm pattern at 45 degrees, and a 30 mm centre hole
let dia = 100.0; // [85.0, 120.0] Disc diameter (mm)
let slot_l = 16.0; // [8.0, 24.0] Slot length (mm)
const t = 5.0;
let d = cylinder([0, 0, 0], "Z", dia / 2.0, t) - (cylinder([0, 0, t - 2.0], "Z", dia / 2.0 + 1.0, 3.0) - cylinder([0, 0, t - 3.0], "Z", dia / 2.0 - 3.0, 5.0));
let slots = [cylinder([0, 0, -1.0], "Z", 15.0, t + 2.0)];
for i in 0..4 {
    let c = 28.28;
    slots.push((box_centered(slot_l - 6.5, 6.5, t + 2.0).translate([c, 0, t / 2.0]) + cylinder([c - (slot_l - 6.5) / 2.0, 0, -1.0], "Z", 3.25, t + 2.0) + cylinder([c + (slot_l - 6.5) / 2.0, 0, -1.0], "Z", 3.25, t + 2.0)).rotate_z(45.0 + 90.0 * i.to_float()));
}
d - fuse_all(slots)
