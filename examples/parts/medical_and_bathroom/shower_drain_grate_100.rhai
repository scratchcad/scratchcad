// 100 mm square shower drain grate: 3 mm stainless plate, ten 4 mm slots, 40 mm tailpiece 30 mm deep with a hair-catch cross
let size = 100.0; // [70.0, 150.0] Grate size (mm)
let thickness = 3.0; // [2.0, 5.0] Plate thickness (mm)
let slots = 10; // [4, 16] Number of slots
let slot_width = 4.0; // [2.5, 6.0] Slot width (mm)
let tail_diameter = 40.0; // [30.0, 60.0] Tailpiece diameter (mm)
let tail_depth = 30.0; // [15.0, 50.0] Tailpiece depth (mm)
let hs = size / 2.0;
let plate = box_centered(size, size, thickness).translate([0, 0, -thickness / 2.0]).fillet(3.0, "|Z").chamfer(0.5, ">Z");
let rt = min(tail_diameter / 2.0, hs - 8.0);
let tail = cylinder([0, 0, -tail_depth], "Z", rt, tail_depth - thickness + 0.1) - cylinder([0, 0, -tail_depth - 1.0], "Z", rt - 2.0, tail_depth + 1.0);
let cross = box_centered(2.0 * rt - 1.0, 2.0, 4.0).translate([0, 0, -tail_depth + 2.0]);
cross = cross + cross.rotate_z(90.0);
let grate = fuse_all([plate, tail, cross]);
let pitch = (size - 16.0) / slots.to_float();
let cuts = [];
for i in 0..slots {
    let x = -hs + 8.0 + pitch * (i.to_float() + 0.5);
    cuts.push(box_centered(min(slot_width, pitch - 2.0), size - 20.0, thickness + 2.0).translate([x, 0, -thickness / 2.0]).fillet(min(slot_width, pitch - 2.0) * 0.45, "|Z"));
}
grate - compound(cuts)
