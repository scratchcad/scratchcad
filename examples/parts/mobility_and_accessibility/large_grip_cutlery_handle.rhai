// Large-grip cutlery handle: 32 mm diameter x 110 mm built-up handle that slides over a standard fork or spoon shank, 12 x 3 mm shank slot 60 mm deep, 8 grip flats and a 6 mm thumb dimple, rounded ends
// # Handle
let diameter = 32.0; // [25.0, 45.0] Handle diameter (mm)
let length = 110.0; // [80.0, 140.0] Handle length (mm)
let flats = 8; // [0, 12] Number of grip flats
// # Shank slot
let slot_width = 12.0; // [6.0, 16.0] Shank slot width (mm)
let slot_thickness = 3.0; // [2.0, 5.0] Shank slot thickness (mm)
let slot_depth = 60.0; // [30.0, 90.0] Shank slot depth (mm)
let r = diameter / 2.0;
let handle = cylinder([0, 0, 0], "X", r, length).fillet(min(6.0, r * 0.4));
let cuts = [];
for i in 0..flats {
    cuts.push(box_from_corners([10.0, -r, r - 1.2], [length - 10.0, r, r + 2.0]).rotate_x(i.to_float() * 360.0 / flats.to_float()));
}
let shaped = if flats > 0 { handle - fuse_all(cuts) } else { handle };
let depth = min(slot_depth, length - 15.0);
let slot = box_from_corners([-1.0, -slot_width / 2.0, -slot_thickness / 2.0], [depth, slot_width / 2.0, slot_thickness / 2.0]);
let thumb = sphere([length * 0.35, 0, r + 4.0], 6.0);
shaped - slot - thumb
